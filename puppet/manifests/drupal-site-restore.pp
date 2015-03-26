# A class to restore a drupal site with drush
class drupal::site::restore (
  $website = hiera('website'),
) {
  # Restore from a backup
  exec{"drush-archive-restore-${website}":
    command => "drush archive-restore \
      --destination=/var/www/drupal \
      --db-url=mysql://root@localhost/drupal \
      --overwrite \
      /apps/drupal/backups/archive-dump/${website}-latest.tar.gz",
    creates => '/var/www/drupal/index.php',
    user => 'vagrant',
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
    require => [
      Php::Pear::Module['drush'],
      Nsidc_nfs::Sharemount['/apps/drupal'],
    ],
    notify => [
      File["/var/www/drupal/sites/${website}/files"],
      File["/var/www/drupal/sites/${website}/private-files"],
    ]
  }
}

