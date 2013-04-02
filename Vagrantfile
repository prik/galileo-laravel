# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.host_name = "precise32"

  config.vm.network :hostonly, "33.33.33.33"
  
  config.vm.forward_port 22, 2222
  config.vm.forward_port 80, 8888
  config.vm.forward_port 3306, 3333
  
  config.vm.share_folder("v-root", "/vagrant/www", "./www", :extra => 'dmode=777,fmode=777')

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file = "base.pp"
  end

end