# A class to install drupal (or only drush)
class drupal(
  $install = false,
  $version = 7,
  $drush_version = '7.x',
  $drupal_parent_directory = '/var/www',
  $drupal_user = 'www-data',
  $admin_user = 'vagrant',
  $admin_group = 'vagrant',
  $mail_domain = undef,
  $mail_server = undef,
) {

  # Load several puppet classes to setup the LAMP stack for Drupal
  include ::drupal::apache
  include ::drupal::php
  include ::mysql::server

  # Need this until next version of puppet-mysql (>3.6.1) is released
  File['mysql-config-file'] ~> Service['mysqld']

  # Create a log directory for drupal logs
  file{'/var/log/drupal':
    ensure => directory,
  }

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
    require => Class['drupal::apache']
  }

  # Install drush using composer
  exec {'install-drush':
    command => "su - ${admin_user} -c \"composer global require drush/drush:${drush_version}\"",
    path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
    creates => "/home/${admin_user}/.config/composer/vendor/bin/drush",
    before => Exec['symlink-drush'],
    require => Class['::php::composer'],
  }
  exec {'symlink-drush':
    command => "ln -s /home/${admin_user}/.config/composer/vendor/bin/drush /usr/local/bin/",
    creates => '/usr/local/bin/drush',
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  # Use drush to install drupal
  if $install {

    # Download drupal
    exec{'drush-download-drupal':
      command => "yes | drush pm-download \
        --verbose \
        --destination=${drupal_parent_directory} \
        drupal-${version}
      ",
      user => $admin_user,
      provider => shell,
      creates => "${drupal_parent_directory}/drupal/index.php",
      path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
      require => [ Exec['install-drush'], File[$drupal_parent_directory] ],
      notify => Exec['rename-drupal']
    }

    # Rename drupal directory to be just "drupal"
    exec{'rename-drupal':
      command => "mv ${drupal_parent_directory}/drupal* ${drupal_parent_directory}/drupal",
      refreshonly => true,
      creates => "${drupal_parent_directory}/drupal",
      path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
    }

  }
}

