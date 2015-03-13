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

