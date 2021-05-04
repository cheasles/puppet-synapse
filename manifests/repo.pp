# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include synapse::repo
class synapse::repo () inherits synapse {
  if $synapse::repo_manage {
    require apt
    create_resources('apt::source', $synapse::repo_sources)
  }
}
