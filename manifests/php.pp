# A class to configure PHP for Drupal
class drupal::php () {

  # PHP class-level settings
  class {'::php':
    settings => {
      'max_execution_time' => '600',
      'error_reporting' => 'E_ALL',
      'memory_limit' => '1024M',
      'post_max_size' => '500M',
      'register_globals' => 'Off',
      'upload_max_filesize' => '500M',
      'max_input_vars' => '9999',
      'log_errors' => '1',
      'error_log' => '/var/log/drupal/php-error.log'
    },
    require => [
      File['symlink-upstart-php-log'],
      File['symlink-fpm-php-log'],
    ]
  }

  # Symlink upstart log into our log dir
  # https://bugs.launchpad.net/ubuntu/+source/php5/+bug/1319595
  file{'symlink-upstart-php-log':
    path => '/var/log/upstart/php5-fpm.log',
    ensure => 'link',
    target => '/var/log/drupal/php5-fpm.log',
    require => File['php5-fpm-log']
  }
  file{'symlink-fpm-php-log':
    path => '/var/log/php5-fpm.log',
    ensure => 'link',
    target => '/var/log/drupal/php5-fpm.log',
    require => File['php5-fpm-log']
  }
  file{'php5-fpm-log':
    ensure => file,
    path => '/var/log/drupal/php5-fpm.log',
    require => File['/var/log/drupal'],
  }
  file{'php5-error-log':
    ensure => file,
    path => '/var/log/drupal/php-error.log',
    require => File['/var/log/drupal'],
  }

  # FPM pool configuration
  php::fpm::pool{'drupal':
    listen => '/var/run/php5-fpm.sock',
    listen_mode => '0666',
    catch_workers_output => yes,
  }

  # PHP Extensions
  php::extension{'ldap':}
  php::extension{'gd':}
  php::extension{'imagick':}
  php::extension{'json':}
  php::extension{'mysqlnd':}
  php::extension{'curl':}
  php::extension{'apcu':}
  php::extension{'xhprof':
    notify => Exec['fix-comments-in-xhprof']
  }

  # Fix comments from xhprof.ini
  # (pound signs are deprecated and generate php warnings)
  exec { 'fix-comments-in-xhprof':
    refreshonly => true,
    command => "sed -i 's/^#/;/' /etc/php5/mods-available/xhprof.ini",
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
    require => Php::Extension['xhprof']
  }

  # Configure apcu for upload progress
  file_line { 'apc.rfc1867':
    path => '/etc/php5/mods-available/apcu.ini',
    line => 'apc.rfc1867 = 1',
    require => Php::Extension['apcu']
  }

}
