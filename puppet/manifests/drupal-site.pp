# A class to setup a drupal site
class drupal::site (
  $website = hiera('website', 'localhost'),
  $restore = undef,
  $drupal_parent_directory = '/var/www',
) {

  # Setup drush config file for the vagrant user
#   file{'/home/vagrant/.drush':
#     ensure => directory,
#     owner => 'vagrant'
#   }
#   file{'/home/vagrant/.drush/drushrc.php':
#     content => "<?php \
#     \$options[\"r\"] = \"${drupal_parent_directory}/drupal\" \
#     \$options[\"l\"] = \"http://${website}\"; \
#     ",
#     owner => 'vagrant'
#   }

  # Set files and private-files to be owned by www-data (default web user)
  # Use chown because puppet file recursion can take a long time with many files
  file { "public-files-${website}":
    path => "${drupal_parent_directory}/drupal/sites/${website}/files",
    ensure => 'directory',
    owner => 'www-data',
    group => 'www-data',
    require => Package['apache2'],
    notify => Exec['chown-drupal-files'],
  }
  file { "private-files-${website}":
    path => "${drupal_parent_directory}/drupal/sites/${website}/private-files",
    ensure => 'directory',
    owner => 'www-data',
    group => 'www-data',
    require => Package['apache2'],
    notify => Exec['chown-drupal-files'],
  }
  exec {'chown-drupal-files':
    command => "chown -Rh www-data:www-data \
      ${drupal_parent_directory}/drupal/sites/${website}/files \
      ${drupal_parent_directory}/drupal/sites/${website}/private-files",
    refreshonly => true,
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  # Use drush to restore the site
  if $restore {

    # Restore parameter is a filename
    file{"${restore}": }

    exec{"drush-archive-restore-${website}":
      command => "drush archive-restore \
        --destination=${drupal_parent_directory}/drupal \
        --db-url=mysql://root@localhost/drupal \
        --overwrite \
        ${restore}",
      creates => "${drupal_parent_directory}/drupal/index.php",
      user => 'vagrant',
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      require => [
        Php::Pear::Module['drush'],
        File[$restore],
      ],
      notify => [
        File["public-files-${website}"],
        File["private-files-${website}"],
      ]
    }
  }

}

