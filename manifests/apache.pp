# A class to configure Apache to work with Vagrant and Drupal
class drupal::apache() {

  # Install Apache
  package { 'apache2': }
  package { 'apache2-utils': }
  package { 'apache2-dev': }
  package { 'libapache2-mod-fastcgi': }
  package { 'libapache2-mod-php5': }

  # Enable the Apache service
  service { 'apache2':
    ensure => running,
    enable => true,
    require => [
      Package['apache2'],
      Package['apache2-dev'],
      Package['libapache2-mod-fastcgi'],
      Drupal::Apache::Module['mpm_worker'],
      File['/var/log/apache2/drupal'],
    ]
  }

  # Fix up Apache default permissions 

  # Grant general read permissions to apache logs for troubleshooting
  file { '/var/log/apache2':
    ensure => 'directory',
    mode => 'a+rx',
    require => Package['apache2'],
    before => File['/var/log/apache2/drupal']
  }
  file { '/var/log/apache2/drupal':
    ensure => 'directory',
    mode => 'a+rx',
    require => Package['apache2'],
    notify => Exec['chmod-var-log-apache2']
  }
  exec { 'chmod-var-log-apache2':
    command => 'chmod -R a+r /var/log/apache2',
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
    refreshonly => true,
  }

  # Disable some default server-wide http settings
  drupal::apache::conf{'security': status => 'disabled' }

  # Enable some custom server-wide http settings
  drupal::apache::conf{'http-settings':}

  # Disable default site
  drupal::apache::site{'000-default': status => 'disabled' }

  # apache conf files
  file { '/etc/apache2/conf-available':
    ensure => directory,
    source => 'puppet:///modules/drupal/apache/conf-available',
    recurse => true,
    notify => Service['apache2'],
    require => Package['apache2'],
  }

  # apache site files
  file { '/etc/apache2/sites-available':
    ensure => directory,
    source => 'puppet:///modules/drupal/apache/sites-available',
    recurse => true,
    notify => Service['apache2'],
    require => [
      Package['apache2'],
      File['/etc/apache2/conf-available'],
    ]
  }

  # Enable fastcgi settings
  drupal::apache::conf{'php5-fpm':
    require => [
      Drupal::Apache::Module['mpm_worker'],
      Drupal::Apache::Module['actions'],
    ],
  }

  # Enable Apache modules for Drupal
  drupal::apache::module{'ssl':}
  drupal::apache::module{'rewrite':}
  drupal::apache::module{'fastcgi':}
  drupal::apache::module{'actions':}

  # Switch Apache from prefork to worker (worker is better)
  # Disable mod_php (not supported by worker, using fastcgi and php5-fpm instead)
  drupal::apache::module{'mpm_prefork':
    status => 'disabled',
    require => Drupal::Apache::Module['php5']
  }
  drupal::apache::module{'php5':
    status => 'disabled',
    require => Package['libapache2-mod-php5']
  }
  drupal::apache::module{'mpm_worker':
    require => [
      Drupal::Apache::Module['mpm_prefork'],
      Drupal::Apache::Module['php5'],
    ],
  }

  # Enable drupal apache site
  drupal::apache::site{'drupal':}

}

