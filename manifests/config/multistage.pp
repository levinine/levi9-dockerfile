#
define dockerfile::config::multistage
  (
    String $dockerfile,
    Hash   $conf,
    String $ensure = 'present',
  )
  {
    concat { $dockerfile:
      ensure => $ensure,
    }

    $stage_defaults = {
      dockerfile => $dockerfile,
    }
    create_resources('dockerfile::config::stage', $conf, $stage_defaults)
  }