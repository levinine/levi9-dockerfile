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
#
define dockerfile::config::stage
  (
    String $dockerfile,
    String $ensure                                 = 'present',
    Variant[Hash, Undef] $arg                      = undef,
    Variant[Hash, Undef] $from                     = undef,
    Variant[Hash, Undef] $copy                     = undef,
    Variant[Hash, Undef] $add                      = undef,
    Variant[Hash, Undef] $env                      = undef,
    Variant[Array, String, Integer, Undef] $expose = undef, # String,Integer are left for compatibility with older versions
    Variant[Hash, Undef] $label                    = undef,
    Variant[String, Undef] $stopsignal             = undef,
    Variant[String, Undef] $user                   = undef,
    Variant[Array, String, Undef] $volume          = undef,
    Variant[String, Undef] $workdir                = undef,
    Variant[String, Hash, Undef] $healthcheck      = undef,
    Variant[Array, Undef] $cmd                     = undef,
    Variant[Array, Undef] $entrypoint              = undef,
    Variant[Array, Undef] $shell                   = undef,
    Variant[Array, String, Undef] $run             = undef,
    Hash $pre                                      = {},
    Hash $post                                     = {},
    Variant[String, Undef] $order                  = undef,
  )
  {
    if $ensure != 'absent' {
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
  }