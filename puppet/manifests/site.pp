# Load puppet options from vagrant-nsidc.yaml
$puppet = hiera_hash('puppet')
$puppet_options = $puppet['apply']['options']
$puppet_manifest = $puppet['apply']['manifest']

# Load modules and classes
hiera_include('classes')

if $environment == 'ci' {

  # Testing dependencies
  package { 'rake':
    provider => 'gem'
  }
  package { 'rspec':
    provider => 'gem'
  }
  package { 'rspec-puppet':
    provider => 'gem'
  }
  package { 'puppet-lint':
    provider => 'gem'
  }

} else {

  class { 'drupal':
    install => true,
    mail_domain => 'example.com',
    mail_server => 'smtp.example.com'
  }

  drupal::site { 'localhost':
    enabled => 'default',
    cookie_domain => 'nsidc.org',
  }
}
