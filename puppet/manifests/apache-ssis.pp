
# Enable Apache modules for handling SSI's
apache::module{'proxy':}
apache::module{'proxy_http':}
apache::module{'include':}

# Disabe mod_deflate for now, it breaks SSI's
apache::module{'deflate':
  status => 'disabled',
}

