# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # Standard port forwarwding
  config.vm.network "forwarded_port", guest: 80, host: 9080
  config.vm.network "forwarded_port", guest: 443, host: 9443

  # Sync themes
  config.vm.synced_folder "themes/", "/var/www/drupal/sites/all/themes/"

  # Puppet config
  config.vm.provision :nsidc_puppet

end
