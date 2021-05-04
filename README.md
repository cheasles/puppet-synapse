# Matrix Synapse

This module installs and configures [Matrix Synapse](https://github.com/matrix-org/synapse/).

## Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with synapse](#setup)
    * [What synapse affects](#what-synapse-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with synapse](#beginning-with-synapse)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This module installs and configures Matrix Synapse.

## Setup

### What synapse affects

* Configures Apt to use the Matrix repositories (if enabled).
* Installs the Synapse package using the system package manager.
* Configures Synapse using the settings specific in the manifest.
* Manages the Synapse service.

### Setup Requirements

This module by default configures Synapse to listen on 127.0.0.1:8008.
If you want to connect to it remotely, you'll need to configure a frontend webserver or change the default bind address.

### Beginning with synapse

To get started, simply include the `synapse` class as follows:

``` puppet
include ::synapse
```

The default settings will install Synapse and configure it to listen on 127.0.0.1:8008.
You should configure a frontend webserver to proxy through to that address.

You should provide new values for `registration_secret` and `macaroon_secret_key`.

## Usage

### Secrets

The default configuration doesn't provide secure values for `registration_secret` and `macaroon_secret_key`.
You can set them with the following Hiera:

``` yaml
synapse::registration_secret: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
synapse::macaroon_secret_key: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
```

### Changing the Default Bind Address

To change what address Synapse binds to, use the following Hiera:

``` yaml
synapse::listen_address: 127.0.0.1
synapse::listen_port: 8008
```

### LDAP Integration

To enable LDAP integration for logging in, you can use the following:

``` yaml
synapse::registration_enabled: false
synapse::additional_config:
  password_providers:
    - module: 'ldap_auth_provider.LdapAuthProvider'
      config:
        enabled: true
        uri: 'my-ldap-server.com'
        start_tls: true
        base: 'ou=Users,dc=my-ldap-server,dc=com'
        attributes:
            uid: "cn"
            mail: "mail"
            name: "givenName"
        # Search auth if anonymous search not enabled
        bind_dn: 'cn=reader,dc=my-ldap-server,dc=com'
        bind_password: 'reader password'
        filter: '(objectClass=posixAccount)'
```

## Limitations

There are currently no known issues.

## Development

If you'd like to contribute, please see [CONTRIBUTING](CONTRIBUTING.md).
