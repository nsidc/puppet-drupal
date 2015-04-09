# A defined type to setup a drupal site
define drupal::site (
  $website = $title,
  $restore = undef,
  $create = undef,
  $drupal_parent_directory = '/var/www',
  $default = true,
  $enabled = true,
) {

  # Skip everything if this site is disabled
  if $enabled {

    # Create drupal files directories
    exec {"mkdir-drupal-files-${website}":
      command => "mkdir -p \
        ${drupal_parent_directory}/drupal/sites/${website}/files \
        ${drupal_parent_directory}/drupal/sites/${website}/private-files",
      creates => "${drupal_parent_directory}/drupal/sites/${website}/files",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
    }
    # Set public files to be owned by www-data (default web user)
    file { "public-files-${website}":
      path => "${drupal_parent_directory}/drupal/sites/${website}/files",
      ensure => 'directory',
      owner => 'www-data',
      group => 'www-data',
      require => [ Package['apache2'], Exec["mkdir-drupal-files-${website}"] ],
      notify => Exec["chown-drupal-files-${website}"],
    }
    # Set private files to be owned by www-data (default web user)
    file { "private-files-${website}":
      path => "${drupal_parent_directory}/drupal/sites/${website}/private-files",
      ensure => 'directory',
      owner => 'www-data',
      group => 'www-data',
      require => [ Package['apache2'], Exec["mkdir-drupal-files-${website}"] ],
      notify => Exec["chown-drupal-files-${website}"],
    }
    # Use chown because puppet file recursion can take a long time with many files
    exec {"chown-drupal-files-${website}":
      command => "chown -Rh www-data:www-data \
        ${drupal_parent_directory}/drupal/sites/${website}/files \
        ${drupal_parent_directory}/drupal/sites/${website}/private-files",
      refreshonly => true,
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
    }

    # Use a symlink to point the "default" site to this site
    if $default {
      file { "defaultsite-${website}":
        ensure => link,
        path => "${drupal_parent_directory}/drupal/sites/default",
        target => "${drupal_parent_directory}/drupal/sites/${website}",
        force => true,
      }
    }

    if $create {
      # Use drush to create the site
      exec{"drush-site-install-${website}":
        command => "yes | drush site-install standard \
          --verbose \
          --site-name=${website} \
          --sites-subdir=${website} \
          --account-name=admin \
          --account-pass=admin \
          --db-url=mysql://root@localhost/drupal",
        cwd => "${drupal_parent_directory}/drupal",
        user => 'vagrant',
        provider => shell,
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        require => PHP::Pear::Module['drush'],
        creates => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
        notify => [
          File["public-files-${website}"],
          File["private-files-${website}"],
          File["defaultsite-${website}"],
        ]
      }

    } elsif $restore {
      # Get filename from restore parameter
      file{"${restore}": }
      # Use drush to restore the site
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
          File["defaultsite-${website}"],
        ]
      }
    }

  }
}

