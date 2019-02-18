#
define dockerfile::config::plain
  (
    String $dockerfile,
    Hash   $conf,
    String $ensure = 'present',
  )
  {
    file { $dockerfile:
      ensure  => $ensure,
      content => epp('dockerfile/plain.epp'),
    }
  }