# A defined type to enable an apache site (Debian style)
define apache::site ($site = $title, $status = 'enabled') {
  if $status == 'enabled' {
    exec { "a2ensite ${site}":
      creates => "/etc/apache2/sites-enabled/${site}.conf",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      notify => Service['apache2'],
      require => [
        File['/etc/apache2/sites-available'],
        Package['apache2'],
      ]
    }
  } else {
    exec { "a2dissite ${site}":
      onlyif => "test -e /etc/apache2/sites-enabled/${site}.conf",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      notify => Service['apache2'],
      require => [
        File['/etc/apache2/sites-available'],
        Package['apache2'],
      ]
    }
  }
}

