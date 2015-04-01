# A class to setup apache to parse SSI's and proxy certain paths used in SSI's
class drupal::apache::ssis () {

  # Enable Apache modules for handling SSI's
  drupal::apache::module{'proxy':}
  drupal::apache::module{'proxy_http':}
  drupal::apache::module{'include':}

  # Disabe mod_deflate for now, it breaks SSI's
  drupal::apache::module{'deflate':
    status => 'disabled',
  }
}
