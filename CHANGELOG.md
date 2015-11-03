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
