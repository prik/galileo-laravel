# Galileo

This repo houses the Puppet manifests and Vagrantfile that we use for local Laravel 4 based development on Mac OS X.

### Puppet manifests included:
- NGINX
- PHP-FPM
- MySQL
- Composer

### Requirements
- VirtualBox
- Vagrant


### Setting it Up

1. [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads), install it.

2. [Download Vagrant](http://www.vagrantup.com/), install it. 
3. Clone the **Galileo** repo into where you want to have your Vagrant box setup. This repo contains the Vagrantfile which will configure your box and Puppet manifests for provisioning of the box.

		git clone https://github.com/bureaublank/galileo.git
		
4. Once cloned, cd into the directory, and run:
		
		vagrant up
		
5. **This will attempt to boot up your box. It may take a while depending on your connection!**   
A few things are happening: First, it's downloading an Ubuntu Precise32 box (the OS the virtual box will run) if you don't already have it. After that's done, the box will boot and Puppet will provision the empty box with the stack described above. 

6. Once it's all done, you should be able to 