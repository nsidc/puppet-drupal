# A class to install drupal (or only drush)
class drupal(
  $install = false,
  $version = 7,
  $drupal_parent_directory = '/var/www',
  $drupal_user = 'www-data'
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

  # Setup drush alias for the vagrant user
  file{'/home/vagrant/.bash_aliases':
    content => "alias drush=\"sudo -u ${drupal_user}\"",
    owner => 'vagrant'
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
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      require => PHP::Pear::Module['drush']
    }
  }
}

