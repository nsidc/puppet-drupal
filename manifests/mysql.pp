# A class to setup mysql for drupal
class drupal::mysql () {

  # Install the database software and start it
  package{'mysql-server':}
  service{'mysql':
    ensure => running,
    enable => true,
    require => Package['mysql-server']
  }

}
