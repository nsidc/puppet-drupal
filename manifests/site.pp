# A defined type to setup a drupal site
define drupal::site (
  $website = $title,
  $cookie_domain = undef,
  $search_cron_limit = undef,
  $restore = undef,
  $drupal_parent_directory = '/var/www',
  $drupal_user = 'www-data',
  $admin_user = 'vagrant',
  $admin_group = 'vagrant',
  $cron_minute = '10',
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
      group => $admin_group,
      mode => 'g+sw',
      require => [ Package['apache2'], Exec["mkdir-drupal-files-${website}"] ],
      notify => Exec["chown-drupal-files-${website}"],
    }
    # Set private files to be owned by the user drupal runs as
    file { "private-files-${website}":
      path => "${drupal_parent_directory}/drupal/sites/${website}/private-files",
      ensure => 'directory',
      owner => $drupal_user,
      group => $admin_group,
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
      command => "chown -Rh ${drupal_user}:${admin_group} \
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

    # Setup system cron for Drupal
    cron { "drupal-${website}":
      command => "cd ${drupal_parent_directory}/drupal/sites/${website} \
        && /usr/bin/env PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin COLUMNS=72 drush --quiet cron",
      user    => $drupal_user,
      minute  => $cron_minute,
    }

    # If specified, configure the search_cron_limit for this drupal site.
    # In the future, this directive can be used to disable Drupal core search indexing,
    #  if/when it is replaced with Apache Solr
    # https://www.drupal.org/node/985484
    if $search_cron_limit {
      file_line {"search-cron-limit-${website}":
        match => "[#]?.*\$conf[\'search_cron_limit\']",
        line => "\$conf[\'search_cron_limit\'] = \'${search_cron_limit}\';",
        path => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
      }
    } else {
      file_line {"search-cron-limit-${website}":
        match => "[#]?.*\$conf[\'search_cron_limit\']",
        line => "# \$conf[\'search_cron_limit\'] not specified via puppet",
        path => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
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
        line => '# cookie_domain not specified via puppet',
        path => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
      }
    }

    # Restore from a backup using drush 
    if $restore {

      # Create drupal database first
      exec{"mysql-create-drupal-database":
        command => 'mysql < "create database drupal"',
        provider => shell,
        unless => "test -f ${drupal_parent_directory}/drupal/sites/${website}/settings.php",
        user => root,
        path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
        require => Service['mysql'],
      }

      # Get filename from restore parameter
      file{$restore:}
      exec{"drush-archive-restore-${website}":
        command => "drush archive-restore \
          --destination=${drupal_parent_directory}/drupal \
          --db-url=mysql://root@localhost/drupal \
          --overwrite \
          ${restore}",
        creates => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
        user => $admin_user,
        path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
        require => [
          Exec['install-drush'],
          Exec['mysql-create-drupal-database'],
          File[$restore],
          File[$drupal_parent_directory],
        ],
        notify => [
          Exec["mkdir-drupal-files-${website}"],
          File["defaultsite-${website}"],
          File_line["cookie-domain-${website}"],
          File_line["search-cron-limit-${website}"],
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
        user => $admin_user,
        provider => shell,
        path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
        require => Exec['drush-download-drupal'],
        creates => "${drupal_parent_directory}/drupal/sites/${website}/settings.php",
        notify => [
          Exec["mkdir-drupal-files-${website}"],
          File["defaultsite-${website}"],
          File_line["cookie-domain-${website}"],
          File_line["search-cron-limit-${website}"],
          Exec["drush-vset-file_public_path-${website}"]
        ]
      }
      # Set the public files location
      exec{"drush-vset-file_public_path-${website}":
        command => "drush vset file_public_path sites/${website}/files",
        cwd => "${drupal_parent_directory}/drupal",
        user => $admin_user,
        path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
        require => [
          Exec['install-drush'],
          File["defaultsite-${website}"],
        ],
        refreshonly => true,
      }
    }

  }
}

