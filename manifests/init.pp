#
class dockerfile
(
  $configs = {}
)
{
  create_resources('dockerfile::config', $configs)
}