# Create a defined type to enable an apache module
define apache::module ($module = $title, $status = 'enabled') {
  if $status == 'enabled' {
    exec { "a2enmod ${module}":
      creates => "/etc/apache2/mods-enabled/${module}.load",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      notify => Service['apache2'],
      require => Package['apache2'],
    }
  } else {
    exec { "a2dismod ${module}":
      onlyif => "test -e /etc/apache2/mods-enabled/${module}.load",
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      notify => Service['apache2'],
      require => File ['/etc/apache2/mods-available'],
    }
  }
}

# Ensure apache module files are available
file { '/etc/apache2/mods-available':
  ensure => directory,
  require => Package['apache2']
}

