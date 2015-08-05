# A class to install drupal (or only drush)
class drupal(
  $install = false,
  $version = 7,
  $drupal_parent_directory = '/var/www',
  $drupal_user = 'www-data',
  $admin_user = 'vagrant',
  $admin_group = 'vagrant',
  $mail_domain = undef,
  $mail_server = undef,
) {

  # Load several puppet classes to setup the LAMP stack for Drupal
  include drupal::apache
  include drupal::mysql
  include drupal::php
  include php

  # Configure postfix to send emails for Drupal
  include postfix
  if $mail_domain {
    postfix::postconf { 'mydomain':
      value => $mail_domain,
      require => Package['postfix'],
      notify => Service['postfix']
    }
    postfix::postconf { 'myorigin':
      value => '$mydomain',
      require => Package['postfix'],
      notify => Service['postfix']
    }
  }
  if $mail_server {
    postfix::postconf { 'relayhost':
      value => "[$mail_server]",
      require => Package['postfix'],
      notify => Service['postfix']
    }
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

  # Setup drush config file for the admin user
  file{"/home/${admin_user}/.drush":
    ensure => directory,
    owner => $admin_user
  }
  file{"/home/${admin_user}/.drush/drushrc.php":
    content => "<?php \
    \$options[\"r\"] = \"${drupal_parent_directory}/drupal\";
    ",
    owner => $admin_user
  }

  # Set drupal install dir to be owned by admin user
  file { $drupal_parent_directory:
    ensure => 'directory',
    owner => $admin_user,
    group => $admin_group,
    recurse => true,
    require => Class['drupal::apache']
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
      user => $admin_user,
      provider => shell,
      creates => "${drupal_parent_directory}/drupal/index.php",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      require => [ PHP::Pear::Module['drush'], File[$drupal_parent_directory] ],
    }
  }
}

