# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
Vagrant::Config.run do |config|
	config.vm.box = "precise64"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"

	config.vm.define "web" do |web|
		web.vm.forward_port 80, 8080
		web.vm.provision "shell", path: "provision.web.sh"

		web.vm.network :hostonly, "192.168.33.10"
  	end

  	config.vm.define "db" do |db|
  		db.vm.provision :shell, path: "provision.db.sh"
		db.vm.network :hostonly, "192.168.33.11"
  	end
end


