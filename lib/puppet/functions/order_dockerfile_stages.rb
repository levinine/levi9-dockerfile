# Increments order attribute in each stage by increment of 10 starting from '10' if not already defined.
# Stages are prefixed with prefix in order to avoid duplicate declarations.
Puppet::Functions.create_function(:order_dockerfile_stages) do
  # @param hash Multistage hash for ordering.
  # @param prefix Prefix for hash keys.
  # @return [Hash] Transformed hash with added order attributes and prefixed keys
  # @example Calling the function
  #   order_dockerfile_stages({
  #     Stage1 => {},
  #     Stage2 => {},
  #     Stage3 => {
  #       order => '15'
  #       }
  #     },
  #     'prefix-'
  #   )
  #   will return
  #   {
  #     prefix-Stage1 => {
  #       order => '10'
  #     },
  #     prefix-Stage2 => {
  #       order => '20'
  #     },
  #     prefix-Stage3 => {
  #       order => '15'
  #     }
  #   }
  dispatch :order_dockerfile_stages do
    param 'Hash', :hash
    param 'String', :prefix
  end

  def order_dockerfile_stages(hash, prefix)
    result = {}
    hash.each_with_index do |(key, value), index|
      prefixed_key = prefix + key
      result[prefixed_key] = value
      result[prefixed_key]['order'] = ((index + 1) * 10).to_s unless result[prefixed_key]['order']
    end
    result
  end
end
