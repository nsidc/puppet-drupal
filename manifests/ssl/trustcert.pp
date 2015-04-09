# Add the ssl certificate for the server and port to the ca-certificates file 
# this makes us always trust the certificate
define drupal::ssl::trustcert ($hostname=$title, $port=443) {
  exec {"openssl-get-certificate-${hostname}":
    command => "echo -n | \
      openssl s_client -connect ${hostname}:${port} | \
      sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' \
      > /usr/local/share/ca-certificates/${hostname}.crt",
    creates => "/usr/local/share/ca-certificates/${hostname}.crt",
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
    provider => 'shell',
    notify => Exec["update-ca-certificates-${hostname}"]
  }
  exec {"update-ca-certificates-${hostname}":
    command => 'update-ca-certificates',
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
    refreshonly => 'true',
  }
}
