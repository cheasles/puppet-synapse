# @summary Configures Matrix Synapse
#
# Creates the required folders and configuration files for Matrix Synapse.
#
# @example
#   include synapse::config
class synapse::config(
  String  $server_name          = $synapse::server_name,
  Integer $listen_port          = $synapse::listen_port,
  String  $listen_address       = $synapse::listen_address,
  String  $database_name        = $synapse::database_name,
  Hash    $database_args        = $synapse::database_args,
  String  $media_store_path     = $synapse::media_store_path,
  String  $uploads_path         = $synapse::uploads_path,
  String  $macaroon_secret_key  = $synapse::macaroon_secret_key,
  Hash    $additional_config    = $synapse::additional_config,
  Boolean $registration_enabled = $synapse::registration_enabled,
  String  $registration_secret  = $synapse::registration_secret,
) inherits synapse {
  file { $synapse::conf_dir:
    ensure => directory,
    owner  => $synapse::user,
    group  => $synapse::group,
    mode   => '0600',
    notify => Service[$synapse::service_name],
  }

  exec { "Create ${synapse::media_store_path}":
    creates => $synapse::media_store_path,
    command => "mkdir -p ${synapse::media_store_path}",
    path    => $::path
  } -> file { $synapse::media_store_path:
    ensure => directory,
    owner  => $synapse::user,
    group  => $synapse::group,
    mode   => '0644',
    notify => Service[$synapse::service_name],
  }

  exec { "Create ${synapse::uploads_path}":
    creates => $synapse::uploads_path,
    command => "mkdir -p ${synapse::uploads_path}",
    path    => $::path
  } -> file { $synapse::uploads_path:
    ensure => directory,
    owner  => $synapse::user,
    group  => $synapse::group,
    mode   => '0644',
    notify => Service[$synapse::service_name],
  }

  file { $synapse::data_dir:
    ensure => directory,
    owner  => $synapse::user,
    group  => $synapse::group,
    mode   => '0644',
    notify => Service[$synapse::service_name],
  }

  concat { "${synapse::conf_dir}/homeserver.yaml":
    ensure  => present,
    owner   => $synapse::user,
    group   => $synapse::group,
    mode    => '0644',
    require => [File[$synapse::conf_dir], Class['synapse::install']],
    notify  => Service[$synapse::service_name]
  }

  concat::fragment { 'synapse-homeserver-config':
    target  => "${synapse::conf_dir}/homeserver.yaml",
    content => hash2yaml($additional_config),
    order   => '01'
  }

  concat::fragment { 'synapse-homeserver':
    target  => "${synapse::conf_dir}/homeserver.yaml",
    content => template('synapse/homeserver.yaml.erb'),
    order   => '02'
  }

  file { "${synapse::conf_dir}/conf.d/server_name.yaml":
    ensure    => absent,
    subscribe => Package[$synapse::package_name],
  }
}
