# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	config.omnibus.chef_version = :latest

	config.vm.box = "opscode-ubuntu-14.04"
	config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

  	config.vm.define "mysql" do |mysql|
  		
		mysql.vm.network "private_network", ip: "192.168.33.12"

		mysql.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "mysql::server"

			chef.json = {
				:mysql => {

					server_root_password: "password",

					version: '5.6',
					port: '3307',
					data_dir: '/data-mysql',
					allow_remote_root: true,
					remove_anonymous_Users: true,
					remove_test_database: true
				}
			}
		end
  	end

	config.vm.define "apache" do |apache|

		apache.vm.provision "shell", path: "provision.apache.sh"

		apache.vm.forward_port 80, 8080
		apache.vm.network "private_network", ip: "192.168.33.10"
  	end


	config.vm.define "nodejs" do |nodejs|

		nodejs.vm.provision "shell", path: "provision.nodejs.sh", privileged: false
		
		nodejs.vm.network "private_network", ip: "192.168.33.11"
  	end

	config.vm.define "minecraft" do |minecraft|

		minecraft.vm.network "private_network", ip: "192.168.33.13"

		minecraft.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "minecraft"
			chef.json = {
				:minecraft => {
					:options => {
						motd: "This server installed with Vagrant",
					online_mode: true
					}
				}
			}
		end
	end
end


