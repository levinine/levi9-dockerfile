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