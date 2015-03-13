
##### Install Apache #####

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

##### Setup Apache files #####

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
  mode => 'a+rx',
  recurse => 'true',
  require => Package['apache2']
}

##### Enable / Disable Apache Modules #####

apache::module{'php5':}
apache::module{'ssl':}
apache::module{'rewrite':}

##### Enable / Disable Apache Config files #####

# Generate defined values in apache config and enable server-wide
apache::conf{'define':}
file{'/etc/apache2/conf-available/define.conf':
  ensure => present,
  content => template('/vagrant/puppet/templates/define.conf.erb'),
}

# Disable some default server-wide http settings
apache::conf{'security': status => 'disabled' }

# Enable some custom server-wide http settings
apache::conf{'http-settings':}

##### Enable / Disable Apache Sites #####

# Disable default site
apache::site{'000-default': status => 'disabled' }

# Enable drupal site
apache::site{'drupal':}

