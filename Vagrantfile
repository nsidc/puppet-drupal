# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # Standard port forwarwding (virtualbox only)
  config.vm.network "forwarded_port", guest: 80, host: 9080
  config.vm.network "forwarded_port", guest: 443, host: 9443

  # Sync /vagrant (change default behavior to explicitly use rsync )
  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  # Symlink /vagrant into the puppet modules folder so it can be loaded like a module
  config.vm.provision "shell", inline: "mkdir -p /vagrant-nsidc-puppet; ln -sf /vagrant /vagrant-nsidc-puppet/drupal"

  # Create directories needed by puppet 4
  environment = VagrantPlugins::NSIDC::Plugin.environment
  config.vm.provision "shell", inline: "
    mkdir -p /etc/puppetlabs/code/environments/#{environment};
    mkdir -p /etc/puppetlabs/puppet;
    mkdir -p /var/log/puppetlabs;
    mkdir -p /opt/puppetlabs/puppet;
  "

  # Apply puppet
  config.vm.provision :nsidc_puppet

end
