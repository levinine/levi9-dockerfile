#
# @summary Manage content of Dockerfiles.
#
# @param configs
#   Configurations for Dockerfiles. Creates dockerfile::config resources.
#
class dockerfile
(
  $configs = {}
)
{
  create_resources('dockerfile::config', $configs)
}