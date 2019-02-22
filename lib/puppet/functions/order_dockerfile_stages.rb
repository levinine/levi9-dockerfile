# Increments order attribute in each stage by increment of 10 starting from '10' if not already defined
Puppet::Functions.create_function(:order_dockerfile_stages) do
  # @param hash Multistage hash for ordering.
  # @return [Hash] Transformed hash with added order attributes
  # @example Calling the function
  #   order_dockerfile_stages({
  #     Stage1 => {},
  #     Stage2 => {},
  #     Stage3 => {
  #       order => '15'
  #     }
  #   })
  # will return
  #   {
  #     Stage1 => {
  #       order => '10'
  #     },
  #     Stage2 => {
  #       order => '20'
  #     },
  #     Stage3 => {
  #       order => '15'
  #     }
  #   }
  dispatch :order_dockerfile_stages do
    param 'Hash', :hash
  end

  def order_dockerfile_stages(hash)
    result = {}
    hash.each_with_index do |(key, value), index|
      result[key] = value
      result[key]['order'] = ((index + 1) * 10).to_s unless result[key]['order']
    end
    result
  end
end
