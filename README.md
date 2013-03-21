# Galileo (Laravel)

This repo houses the Puppet manifests and Vagrantfile that we use for local Laravel 4 based development on Mac OS X.

### Puppet manifests included:
- NGINX
- PHP-FPM (extensions: mcrypt, cli, apc, xdebug, apc)
- MySQL
- Composer
- Laravel 4

### Requirements
- VirtualBox
- Vagrant


### Setting it Up

1. Clone the **Galileo** repo into where you want to have your Vagrant box setup. This repo contains the Vagrantfile which will configure your box and Puppet manifests for provisioning of the box.

		git clone https://github.com/bureaublank/galileo-laravel.git
		
2. Once cloned, cd into the directory, and run:
		
		vagrant up
		
3. **This will start the process. It may take a while depending on your connection!**   
A few things are happening: First, it's downloading an Ubuntu 12.04 Precise32 box if you don't already have it. After that's done, the box will boot and Puppet will provision the empty box with the stack described above. 

4. Once it's all done, just go to [http://localhost:8888](http://localhost:8888) in a web browser and you should see the default Laravel 4 "Hello World!" page. 

5. **The www/ folder where you clone the repo is the web root shared with the virtual machine and where Laravel was installed into. **


---

### Accessing MySQL from Sequel Pro

If you like using Sequel Pro to manage your MySQL databases, you'll be happy to know that you can connect to the MySQL server running inside of the virtual box through Sequel Pro: 

1. Use the SSH option to connect
2. Default credentials are as follows:
	
		MySQL Host: 127.0.0.1
		Username: myadmin
		Password: (blank)
		
		SSH Host: localhost
		SSH User: vagrant
		SSH Pass: vagrant
		SSH Port: 2222
		
3. Click YES to accept the message about keys. 