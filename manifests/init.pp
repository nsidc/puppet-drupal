# A class to install drupal (or only drush)
class drupal(
  $install = false,
  $version = 7,
  $drupal_parent_directory = '/var/www',
) {

  # Load several puppet classes to setup the LAMP stack for Drupal
  include drupal::apache
  include drupal::mysql
  include drupal::php

  # Pass "-y" to php class installation options (works around bug in puppet-php)
  class {'::php':
    install_options => "-y"
  }

  # Create drupal sites from defined types in hiera
  $drupalsites = hiera_hash('drupal::sites', {})
  create_resources('drupal::site', $drupalsites)

  # Install drush (and dependencies) with pear
  php::pear::module { 'drush':
    repository  => 'pear.drush.org',
    use_package  => false,
    require => [
      Php::Pear::Module['Console_Table'],
      Php::Pear::Module['PEAR']
    ]
  }
  php::pear::module { 'Console_Table':
    use_package  => false,
  }
  php::pear::module { 'PEAR':
    use_package  => false,
  }

  # Setup drush config file for the vagrant user
  file{'/home/vagrant/.drush':
    ensure => directory,
    owner => 'vagrant'
  }
  file{'/home/vagrant/.drush/drushrc.php':
    content => "<?php \
    \$options[\"r\"] = \"${drupal_parent_directory}/drupal\"; \
    ",
    owner => 'vagrant'
  }

  # Use drush to install drupal
  if $install {

    # Install drupal7 with drush
    exec{'drush-download-drupal':
      command => "yes | drush pm-download \
        --verbose \
        --drupal-project-rename drupal \
        --destination=${drupal_parent_directory} \
        drupal-${version}
      ",
      user => 'vagrant',
      provider => shell,
      creates => "${drupal_parent_directory}/drupal/index.php",
      notify => Exec['drush-site-install-default'],
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      require => PHP::Pear::Module['drush']
    }

    # Do a standard site installation with all defaults
    exec{'drush-site-install-default':
      command => 'yes | drush site-install standard \
        --verbose \
        --account-name=admin \
        --account-pass=admin \
        --db-url=mysql://root@localhost/drupal',
      cwd => "${drupal_parent_directory}/drupal",
      user => 'vagrant',
      provider => shell,
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      require => PHP::Pear::Module['drush'],
      refreshonly => true,
    }
  }

  # Finish setting up the site with puppet
  drupal::site{'default':
    default => false,
    require => Exec['drush-site-install-default']
  }

}

