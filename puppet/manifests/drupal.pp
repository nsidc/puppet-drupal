# Load website name from yaml
$website = hiera('website')
$drupal_directory = '/var/www/drupal'

# Enable PHP puppet module and install php
# (this fails if install_options is left blank)
class{'php':
  install_options => [ '-y' ],
}

# Install drush (and dependencies) with pear
php::pear::module { 'drush':
  repository  => 'pear.drush.org',
  use_package  => false,
  require => [ 
    Php::Pear::Module['Console_Table'],
    Php::Pear::Module['PEAR']
  ]
}
php::pear::module { 'Console_Table':
  use_package  => false,
}
php::pear::module { 'PEAR':
  use_package  => false,
}

# Install PHP Modules needed for Drupal
php::module {'mysql':}
php::module {'ldap':}
php::module {'gd':}
php::module {'imagick':}
php::module {'json':}

# Setup drush config file for the vagrant user
file{'/home/vagrant/.drush':
  ensure => directory,
  owner => 'vagrant'
}
file{'/home/vagrant/.drush/drushrc.php':
  content => "<?php \
  \$options[\"r\"] = \"${drupal_direcotry}\"; \
  \$options[\"l\"] = \"http://${website}\"; \
  ",
  owner => 'vagrant'
}

# Set files and private-files to be owned by www-date (default web user)
# Use chown because puppet file recursion can take a long time with many files
file { "${drupal_directory}/sites/${website}/files":
  ensure => 'directory',
  owner => 'www-data',
  group => 'www-data',
  require => Package['apache2'],
  notify => Exec['chown-drupal-files'],
}
file { "${drupal_directory}/sites/${website}/private-files":
  ensure => 'directory',
  owner => 'www-data',
  group => 'www-data',
  require => Package['apache2'],
  notify => Exec['chown-drupal-files'],
}
exec {'chown-drupal-files':
  command => "chown -Rh www-data:www-data \
    ${drupal_directory}/sites/${website}/files \
    ${drupal_directory}/sites/${website}/private-files",
  refreshonly => true,
  path => '/bin:/sbin:/usr/bin:/usr/sbin',
}

# Setup environment specific configuration
if $environment == 'local' {
  include drupal::site::install
} else {
  include drupal::site::restore
}

