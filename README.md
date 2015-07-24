# puppet-drupal

## Installation

This module requires at least puppet 3.0. It also has dependencies on other puppet modules from puppet forge. Use librarian-puppet to install it.

Puppetfile:
```shell
forge "https://forgeapi.puppetlabs.com"

mod "nsidc/drupal",
  :git => "git@github.com:/nsidc/puppet-drupal.git",
  :ref => "latest"
```

Command to install:
```shell
$ librarian-puppet update
```

## Usage
To use this puppet module, add something like the below to your hiera config:  
(only one site should be enabled at a time)

```shell

# declare drupal module
classes:
  - drupal

# install drupal with drush 
# (only needed for new sites)
drupal::install: no
drupal::mail_domain: example.com
drupal::mail_server: smtp.example.com

# drupal sites
drupal::sites:
  site1.example.com:
    restore: /path/to/drush/archive
    enabled: default

```

