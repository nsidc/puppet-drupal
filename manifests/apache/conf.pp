# A defined type to enable an apache conf
define drupal::apache::conf ($conf = $title, $status = 'enabled') {
  if $status == 'enabled' {
    exec { "a2enconf ${conf}":
      creates => "/etc/apache2/conf-enabled/${conf}.conf",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      notify => Service['apache2'],
      require => [
        Package['apache2'],
        File['/etc/apache2/conf-available'],
      ]
    }
  } else {
    exec { "a2disconf ${conf}":
      onlyif => "test -e /etc/apache2/conf-enabled/${conf}.conf",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      notify => Service['apache2'],
      require => [
        Package['apache2'],
        File['/etc/apache2/conf-available'],
      ]
    }
  }
}

