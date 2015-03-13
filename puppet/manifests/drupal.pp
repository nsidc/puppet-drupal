
# Enable PHP puppet module and install php
# (this fails if install_options is left blank)
class{'php':
  install_options => [ '-y' ],
}

# PHP Pear Modules
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

# PHP Modules
php::module {'mysql':}
php::module {'ldap':}
php::module {'gd':}
php::module {'imagick':}
php::module {'json':}

# Setup drush config file for the vagrant user
file{'/home/vagrant/.drush':
  ensure => directory,
  owner => 'vagrant'
}
file{'/home/vagrant/.drush/drushrc.php':
  content => '<?php \
  $options["r"] = "/var/www/drupal"; \
  $options["l"] = "http://nsidc.org"; \
  ',
  owner => 'vagrant'
}

# Restore from a backup
exec{'drush-archive-restore-staging-nsidc.org':
  command => 'drush archive-restore \
    --destination=/var/www/drupal \
    --db-url=mysql://root@localhost/drupal \
    /apps/drupal/backups/archive-dump/staging.nsidc.org-20150311.tar.gz',
  creates => '/var/www/drupal',
  user => 'vagrant',
  path => '/bin:/sbin:/usr/bin:/usr/sbin',
  require => [
    Php::Pear::Module['drush'],
    Nsidc_nfs::Sharemount['/apps/drupal'],
  ],
}

# # Install drupal7 with drush
# exec{'drush-install-drupal':
#   command => 'drush pm-download --drupal-project-rename drupal-7',
#   cwd => '/var/www',
#   user => 'vagrant',
#   creates => '/var/www/drupal',
#   notify => Exec['drush-site-install-default'],
#   path => '/bin:/sbin:/usr/bin:/usr/sbin',
#   require => Pear::Package['drush']
# }
# 
# # Do a standard site installation with all defaults
# exec{'drush-site-install-default':
#   command => 'yes | drush site-install standard \
#     --account-name=admin \
#     --account-pass=admin \
#     --db-url=mysql://root@localhost/drupal',
#   cwd => '/var/www/drupal',
#   user => 'vagrant',
#   provider => shell,
#   path => '/bin:/sbin:/usr/bin:/usr/sbin',
#   require => Pear::Package['drush'],
#   refreshonly => true,
# }

