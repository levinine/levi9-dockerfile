# == Define: dockerfile::config::multistage
#
# Manage Dockerfile using concat resource. Supports multistages.
#
# == Parameters
#
# [*dockerfile*]
#  Full path to Dockarefile to manage.
#  Mandatory
#
# [*conf*]
#  Configuration in key/value form. Keys are mapped to names of dockerfile::config::stage resources.
#  Mandatory
#
# [*ensure*]
#  Manage existance of Dockerfile.
#  Defaults to 'present'
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

    $unique_stages = prefix(order_dockerfile_stages($conf), "${name}-")

    create_resources('dockerfile::config::stage', $unique_stages, $stage_defaults)
  }