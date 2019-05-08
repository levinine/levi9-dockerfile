#
# @summary Manage Dockerfile using concat resource. Supports multistages.
#
# @param dockerfile
#   Full path to Dockerfile to manage.
# @param conf
#   Configuration in key/value form. Keys are mapped to names of dockerfile::config::stage resources.
# @param ensure
#   Manage existance of Dockerfile.
# @param owner
#   Specifies the owner of the destination file.
# @param group
#   Specifies a permissions group for the destination file.
# @param mode
#   Specifies the permissions mode of the destination file.
#
define dockerfile::config::multistage
  (
    String $dockerfile,
    Hash   $conf,
    String $ensure                            = 'present',
    Optional[Variant[String, Integer]] $owner = undef,
    Optional[Variant[String, Integer]] $group = undef,
    Optional[Variant[String, Integer]] $mode  = undef,
  )
  {
    concat { $dockerfile:
      ensure => $ensure,
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    $stage_defaults = {
      dockerfile => $dockerfile,
      ensure     => $ensure,
    }

    $unique_stages = order_dockerfile_stages($conf, "${name}-")

    create_resources('dockerfile::config::stage', $unique_stages, $stage_defaults)
  }