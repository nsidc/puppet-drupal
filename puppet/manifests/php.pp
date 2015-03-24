# Enable PHP puppet module and install php
# (this fails if install_options is left blank)
class{'php':
  install_options => [ '-y' ],
}

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

