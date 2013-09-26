# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"

  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.synced_folder "./", "/vagrant", id: "vagrant-root"

  config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "base.pp"
    end

end