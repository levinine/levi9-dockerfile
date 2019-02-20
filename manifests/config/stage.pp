# == Define: dockerfile::config::stage
#
# Single stage configuration for docker::config::multistage. Private defined type.
#
# == Parameters
#
# [*dockerfile*]
#  Target of concat::fragment.
#  Mandatory
#
# [*arg*]
#  ARG instruction of Dockerfile.
#  Defaults to undef
#
# [*from*]
#  FROM instruction of Dockerfile.
#  Defaults to undef
#
# [*copy*]
#  COPY instruction of Dockerfile.
#  Defaults to undef
#
# [*add*]
#  ADD instruction of Dockerfile.
#  Defaults to undef
#
# [*env*]
#  ENV instruction of Dockerfile.
#  Defaults to undef
#
# [*expose*]
#  EXPOSE instruction of Dockerfile.
#  Defaults to undef
#
# [*label*]
#  LABEL instruction of Dockerfile.
#  Defaults to undef
#
# [*stopsignal*]
#  STOPSIGNAL instruction of Dockerfile.
#  Defaults to undef
#
# [*user*]
#  USER instruction of Dockerfile.
#  Defaults to undef
#
# [*volume*]
#  VOLUME instruction of Dockerfile.
#  Defaults to undef
#
# [*workdir*]
#  WORKDIR instruction of Dockerfile.
#  Defaults to undef
#
# [*healthcheck*]
#  HEALTHCHECK instruction of Dockerfile.
#  Defaults to undef
#
# [*cmd*]
#  CMD instruction of Dockerfile.
#  Defaults to undef
#
# [*entrypoint*]
#  ENTRYPOINT instruction of Dockerfile.
#  Defaults to undef
#
# [*shell*]
#  SHELL instruction of Dockerfile.
#  Defaults to undef
#
# [*run*]
#  RUN instruction of Dockerfile.
#  Defaults to undef
#

define dockerfile::config::stage
  (
    String $dockerfile,
    Variant[Hash, Undef] $arg                 = undef,
    Variant[Hash, Undef] $from                = undef,
    Variant[Hash, Undef] $copy                = undef,
    Variant[Hash, Undef] $add                 = undef,
    Variant[Hash, Undef] $env                 = undef,
    Variant[String, Integer, Undef] $expose   = undef,
    Variant[Hash, Undef] $label               = undef,
    Variant[String, Undef] $stopsignal        = undef,
    Variant[String, Undef] $user              = undef,
    Variant[Array, String, Undef] $volume     = undef,
    Variant[String, Undef] $workdir           = undef,
    Variant[String, Hash, Undef] $healthcheck = undef,
    Variant[Array, Undef] $cmd                = undef,
    Variant[Array, Undef] $entrypoint         = undef,
    Variant[Array, Undef] $shell              = undef,
    Variant[Array, String, Undef] $run        = undef,
    Hash $pre                                 = {},
    Hash $post                                = {},
    Variant[String, Undef] $order             = undef,
  )
  {
    concat::fragment { $name:
      target  => $dockerfile,
      order   => $order,
      content => join([
        epp('dockerfile/instructions/arg.epp', { 'arg' => $arg }),
        epp('dockerfile/instructions/from.epp', { 'from' => $from }),
        epp('dockerfile/instructions/env.epp', { 'env' => $env }),
        epp('dockerfile/instructions/workdir.epp', { 'workdir' => $workdir }),
        epp('dockerfile/instructions/shell.epp', { 'shell' => $shell }),
        epp('dockerfile/instructions/run.epp', { 'run' => $pre['run'] }),
        epp('dockerfile/instructions/add.epp', { 'add' => $pre['add'] }),
        epp('dockerfile/instructions/copy.epp', { 'copy' => $pre['copy'] }),
        epp('dockerfile/instructions/run.epp', { 'run' => $run }),
        epp('dockerfile/instructions/add.epp', { 'add' => $add }),
        epp('dockerfile/instructions/copy.epp', { 'copy' => $copy }),
        epp('dockerfile/instructions/run.epp', { 'run' => $post['run'] }),
        epp('dockerfile/instructions/add.epp', { 'add' => $post['add'] }),
        epp('dockerfile/instructions/copy.epp', { 'copy' => $post['copy'] }),
        epp('dockerfile/instructions/expose.epp', { 'expose' => $expose }),
        epp('dockerfile/instructions/label.epp', { 'label' => $label }),
        epp('dockerfile/instructions/stopsignal.epp', { 'stopsignal' => $stopsignal }),
        epp('dockerfile/instructions/user.epp', { 'user' => $user }),
        epp('dockerfile/instructions/volume.epp', { 'volume' => $volume }),
        epp('dockerfile/instructions/cmd.epp', { 'cmd' => $cmd }),
        epp('dockerfile/instructions/entrypoint.epp', { 'entrypoint' => $entrypoint }),
        epp('dockerfile/instructions/healthcheck.epp', { 'healthcheck' => $healthcheck }),
      ])
    }
  }