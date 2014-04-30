# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
Vagrant::Config.run do |config|

	config.vm.box = "precise64"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"

	config.vm.define "apache" do |apache|

		apache.vm.provision "shell", path: "provision.apache.sh"

		apache.vm.forward_port 80, 8080
		apache.vm.network :hostonly, "192.168.33.10"
  	end

  	config.vm.define "mysql" do |mysql|
  		mysql.vm.provision :shell, path: "provision.mysql.sh"
		mysql.vm.network :hostonly, "192.168.33.11"
  	end
end


