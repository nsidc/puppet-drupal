# A class to configure Apache to work with Vagrant and Drupal
class drupal::apache() {

  # Install Apache
  package { 'apache2': }
  package { 'apache2-dev': }
  package { 'libapache2-mod-php5': }

  # Enable the Apache service
  service { 'apache2':
    ensure => running,
    enable => true,
    require => [
      Package['apache2'],
      Package['apache2-dev'],
      Package['libapache2-mod-php5'],
    ]
  }

  # Fix up Apache default permissions 

  # Set /var/www to be owned by vagrant
  file { '/var/www':
    ensure => 'directory',
    owner => 'vagrant',
    group => 'vagrant',
    recurse => 'true',
    require => Package['apache2']
  }

  # Grant read permissions to vagrant and others on apache logs
  file { '/var/log/apache2':
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

  # Add templated values into Apache config as "define" directives
  drupal::apache::conf{'define':
    require => File['/etc/apache2/conf-available/define.conf']
  }
  file{'/etc/apache2/conf-available/define.conf':
    ensure => present,
    content => template('/vagrant/puppet/templates/define.conf.erb'),
  }

  # Copy apache conf files in from /vagrant
  file { '/etc/apache2/conf-available':
    ensure => directory,
    source => '/vagrant/puppet/files/apache/conf-available',
    recurse => true,
    notify => Service['apache2'],
    require => Package['apache2'],
  }

  # Copy apache site files in from /vagrant
  file { '/etc/apache2/sites-available':
    ensure => directory,
    source => '/vagrant/puppet/files/apache/sites-available',
    recurse => true,
    notify => Service['apache2'],
    require => [
      Package['apache2'],
      File['/etc/apache2/conf-available'],
    ]
  }

  # Enable Apache modules for Drupal
  drupal::apache::module{'php5':}
  drupal::apache::module{'ssl':}
  drupal::apache::module{'rewrite':}

  # Enable drupal apache site
  drupal::apache::site{'drupal':}

}

