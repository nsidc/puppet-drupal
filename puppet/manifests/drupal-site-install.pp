# A defined type to install drupal with drush
class drupal::site::install (
  $version = '7',
) {

  # Install drupal7 with drush
  exec{'drush-download-drupal':
    command => "drush pm-download --drupal-project-rename drupal-${version}",
    cwd => '/var/www',
    user => 'vagrant',
    creates => '/var/www/drupal/index.php',
    notify => Exec['drush-site-install-default'],
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
    require => PHP::Pear::Module['drush']
  }

  # Do a standard site installation with all defaults
  exec{'drush-site-install-default':
    command => 'yes | drush site-install standard \
      --account-name=admin \
      --account-pass=admin \
      --db-url=mysql://root@localhost/drupal',
    cwd => '/var/www/drupal',
    user => 'vagrant',
    provider => shell,
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
    require => PHP::Pear::Module['drush'],
    refreshonly => true,
    notify => [
      File["/var/www/drupal/sites/${website}/files"],
      File["/var/www/drupal/sites/${website}/private-files"],
    ]
  }
}

