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
    version => '7',
    drush_version => '7.x',
    install => true,
  }

  drupal::site { 'localhost':
    enabled => 'default',
    cookie_domain => 'nsidc.org',
  }
}
