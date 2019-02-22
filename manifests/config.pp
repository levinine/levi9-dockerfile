# @summary A define that manages a Dockerfile configuration.
#
# @param home
#   Directory in which Dockerfile is located.
# @param dockerfile_name
#   The name of the managed dockerfile
# @param conf
#   Configuration for Dockerfile. Depends on type.
# @param type
#   Type of Dockerfile configuration.
# @param ensure
#   Manage existance of Dockerfile.
# @param owner
#   Specifies the owner of the destination file.
# @param group
#   Specifies a permissions group for the destination file.
# @param mode
#   Specifies the permissions mode of the destination file.
#
define dockerfile::config
  (
    String $home,
    String $dockerfile_name                   = 'Dockerfile',
    Variant[String, Hash] $conf               = {},
    String $type                              = 'multistage',
    String $ensure                            = 'present',
    Optional[Variant[String, Integer]] $owner = undef,
    Optional[Variant[String, Integer]] $group = undef,
    Optional[Variant[String, Integer]] $mode  = undef,
  )
  {
    $dockerfile = "${home}/${dockerfile_name}"

    $config_defaults = {
      ensure     => $ensure,
      dockerfile => $dockerfile,
      conf       => $conf,
      owner      => $owner,
      group      => $group,
      mode       => $mode,
    }

    create_resources("dockerfile::config::${type}", { $name => {} }, $config_defaults)
  }