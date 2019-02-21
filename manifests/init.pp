# == Class: dockerfiles
#
# Manage content of Dockerfiles.
#
# == Parameters
#
# [*configs*]
#  Configurations for Dockerfiles. Creates dockerfile::config resources.
#  Deafults to {}
#

class dockerfile
(
  $configs = {}
)
{
  create_resources('dockerfile::config', $configs)
}