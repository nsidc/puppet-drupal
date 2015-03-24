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

# Grant read permissions on apache logs
file { '/var/log/apache2':
  ensure => 'directory',
  mode => 'a+r',
  recurse => 'true',
  require => Package['apache2']
}

# Disable some default server-wide http settings
apache::conf{'security': status => 'disabled' }

# Enable some custom server-wide http settings
apache::conf{'http-settings':}

# Disable default site
apache::site{'000-default': status => 'disabled' }

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

