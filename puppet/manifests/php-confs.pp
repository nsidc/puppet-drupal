# Create a defined type to enable a php conf
define nsidc::php::conf ($conf = $title, $status = 'enabled', $sapi = 'apache2', $priority = '99') {
  if $status == 'enabled' {
    exec { "php5enmod ${conf}":
      creates => "/etc/php5/${sapi}/conf.d/${priority}-${conf}.ini",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      notify => Service['apache2'],
      require => [
        Package['libapache2-mod-php5'],
        Package['php5-common'],
        File ['/etc/php5/mods-available'],
        File ['/var/log/php'],
      ]
    }
  } else {
    exec { "php5dismod ${conf}":
      onlyif => "test -e /etc/php5/${sapi}/conf.d/${priority}-${conf}.ini",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      notify => Service['apache2'],
      require => [
        Package['libapache2-mod-php5'],
        Package['php5-common'],
        File ['/etc/php5/mods-available'],
        File ['/var/log/php'],
      ]
    }
  }
}

