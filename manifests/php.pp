# A class to configure PHP for Drupal
class drupal::php () {

  # php conf files
  file { '/etc/php5/mods-available':
    ensure => directory,
    source => 'puppet:///modules/drupal/php/mods-available',
    recurse => true,
    notify => Service['apache2'],
    require => Package['php5-common'],
  }

  # Package for common php files 
  # (phpenmod, /etc/php5/, etc.)
  package {'php5-common':}

  # Install and enable the php5-fpm service
  package {'php5-fpm':}
  service{'php5-fpm':
    ensure => running,
    enable => true,
    require => Package['php5-fpm'],
  }

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
  php::module {'fpm':}
  php::module {'xhprof':}
  php::module {'mysqlnd':}

  # Enable drupal php config
  drupal::php::conf{'drupal':
    priority => '99',
  }

}
