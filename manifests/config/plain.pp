#
# @summary Heredoc passthrough from $conf variable to Dockerfile.
#
# @param dockerfile
#   Full path to Dockerfile to manage.
# @param conf
#   Configuration in text form.
# @param ensure
#   Manage existance of Dockerfile.
# @param owner
#   Specifies the owner of the destination file.
# @param group
#   Specifies a permissions group for the destination file.
# @param mode
#   Specifies the permissions mode of the destination file.
#
define dockerfile::config::plain
  (
    String $dockerfile,
    String $conf,
    String $ensure                            = 'present',
    Optional[Variant[String, Integer]] $owner = undef,
    Optional[Variant[String, Integer]] $group = undef,
    Optional[Variant[String, Integer]] $mode  = undef,
  )
  {
    file { $dockerfile:
      ensure  => $ensure,
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => epp('dockerfile/plain.epp', { 'conf' => $conf }),
    }
  }