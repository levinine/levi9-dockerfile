# == Define: dockerfile::config
#
# A define that manages a Dockerfile configuration.
#
# == Parameters
#
# [*home*]
#  Directory in which Dockerfile is located.
#  Mandatory
#
# [*dockerfile_name*]
#  The name of the managed dockerfile
#  Defaults to 'Dockerfile'.
#
# [*conf*]
#  Configuration for Dockerfile. Depends on type.
#  Defaults to {}
#
# [*type*]
#  Type of Dockerfile configuration.
#  Defaults to 'plain'.
#
# [*ensure*]
#  Manage existance of Dockerfile.
#  Defaults to 'present.
#

define dockerfile::config
  (
    String $home,
    String $dockerfile_name = 'Dockerfile',
    Hash   $conf            = {},
    String $type            = 'plain',
    String $ensure          = 'present',
  )
  {
    $dockerfile = "${home}/${dockerfile_name}"

    $config_defaults = {
      ensure     => $ensure,
      dockerfile => $dockerfile,
      conf       => $conf,
    }

    create_resources("dockerfile::config::${type}", { $name => {} }, $config_defaults)
  }