## puppet-drupal 1.2

Bugfixes:

  - Added database creation to drush archive-restore process to fix
    known issue in drush 7.x
  - Changed default drush version to 7.x 
  - Added a DEVELOPMENT.md readme

## puppet-drupal 1.1.1

Bugfixes:

  - Changed default drush version back to 6.x because 7.x will
    not restore the database correctly

## puppet-drupal 1.1.0

Features:

  - Replaced example42/php puppet module with mayflower/php puppet module
  - Switched drush installation method to composer instead of pear

Bugfixes:

  - Updated spec to supply more facts for testing and to run unit tests as root

## puppet-drupal 1.0.2

Bugfixes:

  - Removed errant version number in metadata.json from failed bumpversion

## puppet-drupal 1.0.1

Bugfixes:

  - Removed bumpversion and the release jobs

## puppet-drupal 1.0.0

Features:

  - Installs LAMP stack locally
  - configures PHP via example42 php puppet module
  - enables PHP using Apache mod_fastcgi socket to php-fpm
  - Installs drush via pear
  - Optionally installs drupal via drush
  - Optionally restores drupal + site backup from drush archive file
