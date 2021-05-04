# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include synapse::service
class synapse::service () inherits synapse {
  if $synapse::service_manage {
    service { $synapse::service_name :
      ensure => $synapse::service_ensure,
    }
  }
}
