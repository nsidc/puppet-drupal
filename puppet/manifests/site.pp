# Load modules and classes
hiera_include('classes')

# Mount the drupal apps share
include nsidc_nfs
nsidc_nfs::sharemount{'/apps/drupal':
  project => 'apps',
  share => 'drupal'
}

# Trust the SSL certs for snowldap and iceldap
drupal::ssl::trustcert{'snowldap.colorado.edu': port => 636 }
drupal::ssl::trustcert{'iceldap.colorado.edu':  port => 636 }

include drupal::apache::ssis
