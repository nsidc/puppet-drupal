
# Install drush and dependencies with pear
# PEAR and Console_Table are prerequisites for drush
include pear
pear::package { 'PEAR': }
pear::package { 'Console_Table': }
pear::package { 'drush':
  repository => 'pear.drush.org',
  require => [ Pear::Package['PEAR'], Pear::Package['Console_Table'] ]
}

# Install drupal7 with drush
exec{'drush-install-drupal':
  command => 'drush pm-download --drupal-project-rename drupal-7',
  cwd => '/var/www',
  user => 'vagrant',
  creates => '/var/www/drupal',
  notify => Exec['drush-site-install-default'],
  path => '/bin:/sbin:/usr/bin:/usr/sbin',
  require => Pear::Package['drush']
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
  require => Pear::Package['drush'],
  refreshonly => true,
}

