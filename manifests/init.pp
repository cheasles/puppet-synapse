# @summary Installs and configures Matrix Synapse
#
# Installs and configures Matrix Synapse.
#
# @example
#   include synapse
class synapse(
    String  $user = 'matrix-synapse',
    String  $group = 'users',
    Boolean $repo_manage = false,
    Hash    $repo_sources = {},
    Boolean $package_manage = true,
    String  $package_ensure = 'latest',
    String  $package_name = 'matrix-synapse',
    Array[String]
        $package_extras = [],
    String  $server_name = 'example.com',
    Integer $listen_port = 8008,
    String  $listen_address = '127.0.0.1',
    String  $conf_dir = '/etc/matrix-synapse',
    String  $data_dir = '/var/lib/matrix-synapse',
    String  $database_name = 'sqlite3',
    Hash    $database_args = {'database' => "${data_dir}/synapse.db"},
    String  $media_store_path = "${data_dir}/media",
    String  $uploads_path = "${data_dir}/uploads",
    String  $macaroon_secret_key = 'changeme',
    Boolean $service_manage = true,
    String  $service_name = 'matrix-synapse',
    String  $service_ensure = 'running',
    Hash    $additional_config = {},
    Boolean $registration_enabled = false,
    String  $registration_secret = 'changeme',
) {
    include "${module_name}::repo"
    include "${module_name}::install"
    include "${module_name}::config"
    include "${module_name}::service"
}
