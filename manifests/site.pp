# A defined type to setup a drupal site
define drupal::site (
  $website = $title,
  $cookie_domain = undef,
  $restore = undef,
  $drupal_parent_directory = '/var/www',
  $drupal_user = 'www-data',
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
    # Set public files to be owned by the user drupal runs as
    file { "public-files-${website}":
      path => "${drupal_parent_directory}/drupal/sites/${website}/files",
      ensure => 'directory',
      owner => $drupal_user,
      group => 'vagrant',
      mode => 'g+sw',
      require => [ Package['apache2'], Exec["mkdir-drupal-files-${website}"] ],
      notify => Exec["chown-drupal-files-${website}"],
    }
    # Set private files to be owned by the user drupal runs as
    file { "private-files-${website}":
      path => "${drupal_parent_directory}/drupal/sites/${website}/private-files",
      ensure => 'directory',
      owner => $drupal_user,
      group => 'vagrant',
      mode => 'g+sw',
      require => [ Package['apache2'], Exec["mkdir-drupal-files-${website}"] ],
      notify => [
        Exec["chown-drupal-files-${website}"],
        Exec["chmod-drupal-files-${website}"],
      ]
    }
    # Use chown/chmod because puppet file recursion
    # can take a long time with many files
    exec {"chown-drupal-files-${website}":
      command => "chown -Rh ${drupal_user}:vagrant \
        ${drupal_parent_directory}/drupal/sites/${website}/files \
        ${drupal_parent_directory}/drupal/sites/${website}/private-files",
      refreshonly => true,
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
    }
    exec {"chmod-drupal-files-${website}":
      command => "chmod -R g+sw \
        ${drupal_parent_directory}/drupal/sites/${website}/files \
        ${drupal_parent_directory}/drupal/sites/${website}/private-files",
      refreshonly => true,
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
    }

    # Use a symlink to point the "default" site to this site (if this is the default site)
    if $enabled == 'default' {
      file { "defaultsite-${website}":
        ensure => link,
        path => "${drupal_parent_directory}/drupal/sites/default",
        target => "${drupal_parent_directory}/drupal/sites/${website}",
        force => true,
      }
    } else {
      file { "defaultsite-${website}":
        path => "${drupal_parent_directory}/drupal/sites/default",
      }
    }

    # If specified, configure the cookie domain for this drupal site
    if $cookie_domain {
      file_line {"cookie-domain-${website}":
        match => '[#]?.*\$cookie_domain = .*',
        line => "\$cookie_domain = \'.${cookie_domain}\';",
        path => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
      }
    } else {
      # Otherwise, leave the cookie domain alone
      file_line {"cookie-domain-${website}":
        line => '#cookie_domain not specified via puppet',
        path => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
      }
    }

    # Restore from a backup using drush 
    if $restore {
      # Get filename from restore parameter
      file{$restore:}
      exec{"drush-archive-restore-${website}":
        command => "drush archive-restore \
          --destination=${drupal_parent_directory}/drupal \
          --db-url=mysql://root@localhost/drupal \
          --overwrite \
          ${restore}",
        creates => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
        user => 'vagrant',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        require => [
          Php::Pear::Module['drush'],
          File[$restore],
        ],
        notify => [
          Exec["mkdir-drupal-files-${website}"],
          File["defaultsite-${website}"],
          File_line["cookie-domain-${website}"]
        ]
      }
    } else {
      # If not restoring, create the site using drush instead
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
          Exec["mkdir-drupal-files-${website}"],
          File["defaultsite-${website}"],
          File_line["cookie-domain-${website}"],
          Exec["drush-vset-file_public_path-${website}"]
        ]
      }
      # Set the public files location
      exec{"drush-vset-file_public_path-${website}":
        command => "drush vset file_public_path sites/${website}/files",
        cwd => "${drupal_parent_directory}/drupal",
        user => 'vagrant',
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        require => [
          PHP::Pear::Module['drush'],
          File["defaultsite-${website}"],
        ],
        refreshonly => true,
      }
    }

  }
}

