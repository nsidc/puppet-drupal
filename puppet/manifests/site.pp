# Load modules and classes
hiera_include('classes')

# Mount the drupal apps share
include nsidc_nfs
nsidc_nfs::sharemount{'/apps/drupal':
  project => 'apps',
  share => 'drupal'
}

# Install the database software and start it
package{'mysql-server':}
service{'mysql':
  ensure => running,
  enable => true,
  require => Package['mysql-server']
}

# Trust the SSL certs for snowldap and iceldap
ssl::trustcert{'snowldap.colorado.edu': port => 636 }
ssl::trustcert{'iceldap.colorado.edu':  port => 636 }

# Add templated values into Apache config as "define" directives
apache::conf{'define':}
file{'/etc/apache2/conf-available/define.conf':
  ensure => present,
  content => template('/vagrant/puppet/templates/define.conf.erb'),
}

# Enable Apache modules for handling SSI's
apache::module{'proxy':}
apache::module{'proxy_http':}
apache::module{'include':}

# Disabe mod_deflate for now, it breaks SSI's
apache::module{'deflate':
  status => 'disabled',
}

