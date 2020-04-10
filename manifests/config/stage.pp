#
# @summary Single stage configuration for docker::config::multistage. Private defined type.
#
# @see https://docs.docker.com/engine/reference/builder/
#
# @param dockerfile
#   Target of concat::fragment.
# @param ensure
#   Should stage exist in Dockerfile.
# @param arg
#   ARG instruction of Dockerfile.
# @param from
#   FROM instruction of Dockerfile.
# @param copy
#   COPY instruction of Dockerfile.
# @param add
#   ADD instruction of Dockerfile.
# @param env
#   ENV instruction of Dockerfile.
# @param expose
#   EXPOSE instruction of Dockerfile.
# @param label
#   LABEL instruction of Dockerfile.
# @param stopsignal
#   STOPSIGNAL instruction of Dockerfile.
# @param user
#   USER instruction of Dockerfile.
# @param volume
#   VOLUME instruction of Dockerfile.
# @param workdir
#   WORKDIR instruction of Dockerfile.
# @param healthcheck
#   HEALTHCHECK instruction of Dockerfile.
# @param cmd
#   CMD instruction of Dockerfile.
# @param entrypoint
#   ENTRYPOINT instruction of Dockerfile.
# @param shell
#   SHELL instruction of Dockerfile.
# @param run
#   RUN instruction of Dockerfile.
# @param onbuild
#   All instructions in this stage will be prefixed with ONBUILD.
#
define dockerfile::config::stage
  (
    String $dockerfile,
    String $ensure                                                           = 'present',
    Variant[Hash, Undef] $arg                                                = undef,
    Variant[Hash, Undef] $from                                               = undef,
    Variant[Hash, Undef] $copy                                               = undef,
    Variant[Hash, Undef] $add                                                = undef,
    Variant[Hash, Undef] $env                                                = undef,
    Variant[Array[Variant[String, Integer]], String, Integer, Undef] $expose = undef,
    Variant[Hash, Undef] $label                                              = undef,
    Variant[String, Undef] $stopsignal                                       = undef,
    Variant[String, Undef] $user                                             = undef,
    Variant[Array, String, Undef] $volume                                    = undef,
    Variant[String, Undef] $workdir                                          = undef,
    Variant[String, Hash, Undef] $healthcheck                                = undef,
    Variant[Array, Undef] $cmd                                               = undef,
    Variant[Array, Undef] $entrypoint                                        = undef,
    Variant[Array, Undef] $shell                                             = undef,
    Variant[Array, String, Undef] $run                                       = undef,
    Boolean $onbuild                                                         = false,
    Hash $pre                                                                = {},
    Hash $post                                                               = {},
    Variant[String, Undef] $order                                            = undef,
  )
  {
    if $ensure != 'absent' {
      $content = join([
        epp('dockerfile/instructions/arg.epp', { 'arg' => $arg, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/from.epp', { 'from' => $from, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/env.epp', { 'env' => $env, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/workdir.epp', { 'workdir' => $workdir, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/shell.epp', { 'shell' => $shell, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/run.epp', { 'run' => $pre['run'], 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/add.epp', { 'add' => $pre['add'], 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/copy.epp', { 'copy' => $pre['copy'], 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/run.epp', { 'run' => $run, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/add.epp', { 'add' => $add, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/copy.epp', { 'copy' => $copy, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/run.epp', { 'run' => $post['run'], 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/add.epp', { 'add' => $post['add'], 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/copy.epp', { 'copy' => $post['copy'], 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/expose.epp', { 'expose' => $expose, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/label.epp', { 'label' => $label, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/stopsignal.epp', { 'stopsignal' => $stopsignal, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/user.epp', { 'user' => $user, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/volume.epp', { 'volume' => $volume, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/cmd.epp', { 'cmd' => $cmd, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/entrypoint.epp', { 'entrypoint' => $entrypoint, 'onbuild' => $onbuild }),
        epp('dockerfile/instructions/healthcheck.epp', { 'healthcheck' => $healthcheck, 'onbuild' => $onbuild }),
      ])
      concat::fragment { $name:
        target  => $dockerfile,
        order   => $order,
        content => $content,
      }
    }
  }