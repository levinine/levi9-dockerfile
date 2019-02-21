# == Define: dockerfile::config::plain
#
# Heredoc passthrough from $conf variable to Dockerfile.
#
# == Parameters
#
# [*dockerfile*]
#  Full path to Dockarefile to manage.
#  Mandatory
#
# [*conf*]
#  Configuration in text form.
#  Mandatory
#
# [*ensure*]
#  Manage existance of Dockerfile.
#  Defaults to 'present'
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