# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include synapse::install
class synapse::install () inherits synapse {
  if $synapse::package_manage {
    package { $synapse::package_name:
      ensure => $synapse::package_ensure,
      alias  => 'matrix-synapse',
    }

    ensure_packages(
        $synapse::package_extras,
        { 'ensure' => $synapse::package_ensure }
    )
  }
}
