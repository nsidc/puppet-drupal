## puppet-drupal 1.1.0

Features:

  - Replaced example42/php puppet module with mayflower/php puppet module
  - Switched drush installation method to composer instead of pear

## puppet-drupal 1.0.0

Features:

  - Installs LAMP stack locally
  - configures PHP via example42 php puppet module
  - enables PHP using Apache mod_fastcgi socket to php-fpm
  - Installs drush via pear
  - Optionally installs drupal via drush
  - Optionally restores drupal + site backup from drush archive file
