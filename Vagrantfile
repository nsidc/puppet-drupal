# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # Standard port forwarwding (virtualbox only)
  config.vm.network "forwarded_port", guest: 80, host: 9080
  config.vm.network "forwarded_port", guest: 443, host: 9443

  # Sync /vagrant (change default behavior to explicitly use rsync )
  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  # Sync modules
  config.vm.synced_folder "modules/contrib/", "/var/www/drupal/sites/all/modules/contrib/", type: "rsync"
  config.vm.synced_folder "modules/custom/", "/var/www/drupal/sites/all/modules/custom/", type: "rsync"

  # Sync themes
  config.vm.synced_folder "themes/contrib/", "/var/www/drupal/sites/all/themes/contrib/", type: "rsync"
  config.vm.synced_folder "themes/custom/", "/var/www/drupal/sites/all/themes/custom", type: "rsync"

  # Apply puppet
  config.vm.provision :nsidc_puppet

end
