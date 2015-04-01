# A class to configure PHP for Drupal
class drupal::php () {

  # Copy php conf files in from /vagrant
  file { '/etc/php5/mods-available':
    ensure => directory,
    source => '/vagrant/puppet/files/php/mods-available',
    recurse => true,
    notify => Service['apache2'],
    require => Package['php5-common'],
  }

  # Package for common php files 
  # (phpenmod, /etc/php5/, etc.)
  package {'php5-common':}

  # Setup log directory for php
  file { '/var/log/php':
    ensure => 'directory',
    owner => 'www-data',
  }

  # Install PHP Modules needed for Drupal
  php::module {'mysql':}
  php::module {'ldap':}
  php::module {'gd':}
  php::module {'imagick':}
  php::module {'json':}

  # Enable drupal php config
  drupal::php::conf{'drupal':
    priority => '99',
  }

}
