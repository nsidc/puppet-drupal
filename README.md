# puppet-drupal

## Installation

This module requires at least puppet 3.0. It also has dependencies on other puppet modules from puppet forge. Use librarian-puppet to install it.

Puppetfile:
```shell
forge "https://forgeapi.puppetlabs.com"

mod "nsidc/drupal",
  :git => "git@bitbucket.org:/nsidc/puppet-drupal.git",
  :ref => "latest"
```

Command to install:
```shell
$ librarian-puppet update
```

## Usage

To use this puppet module, add something like the below to your hiera config. 
Currently only one drupal site can enabled at a time.

```shell

# declare drupal module
classes:
  - drupal

# install drupal with drush 
# (unnecessary if restoring a site)
drupal::install: yes

# drupal sites
drupal::sites:
  site1.example.com: {}
    create: true
  site2.example.com: {}
    restore: /path/to/drush/archive
    enabled: false
  site3.example.com: {}
    enabled: false

```

