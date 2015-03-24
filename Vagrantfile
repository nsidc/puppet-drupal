# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # Standard port forwarwding
  config.vm.network "forwarded_port", guest: 80, host: 9080
  config.vm.network "forwarded_port", guest: 443, host: 9443

  # Sync modules
  config.vm.synced_folder "modules/contrib/", "/var/www/drupal/sites/all/modules/contrib/", 
    type: "rsync", rsync__args: ["--verbose", "--archive", "--archive", "--delete", "-z"]
  config.vm.synced_folder "modules/custom/", "/var/www/drupal/sites/all/modules/custom/", 
    type: "rsync", rsync__args: ["--verbose", "--archive", "--archive", "--delete", "-z"]

  # Sync themes
  config.vm.synced_folder "themes/contrib/", "/var/www/drupal/sites/all/themes/", 
    type: "rsync", rsync__args: ["--verbose", "--archive", "--archive", "-z"]
  config.vm.synced_folder "themes/custom/", "/var/www/drupal/sites/all/themes/", 
    type: "rsync", rsync__args: ["--verbose", "--archive", "--archive", "-z"]

  # Apply puppet
  config.vm.provision :nsidc_puppet

end
