# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	config.vm.box = "opscode-ubuntu-14.04"
	config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

	config.omnibus.chef_version = :latest

	config.vm.provision "shell", inline: "echo 'set nocp' > /home/vagrant/.vimrc"

	config.vm.define "nginx" do |nginx|

		nginx.vm.network "private_network", ip: "192.168.33.14"

		nginx.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "nginx"

			chef.json = {
				:nginx => {
					#conf_path: '/etc/nginx.conf'
				}
			}
		end

		nginx.vm.provision "shell",
			inline: "echo -e $1 > /etc/nginx/conf.d/nginx.conf",
			args: [<<-EOS
				server {
					listen *:80;

					location ~ ^/ {
					    proxy_pass http://192.168.33.11:8080;
					}
				}
			EOS
			]

	end

  	config.vm.define "mysql" do |mysql|
  		
		mysql.vm.network "private_network", ip: "192.168.33.13"

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
		apache.vm.network "private_network", ip: "192.168.33.12"
  	end


	config.vm.define "nodejs" do |nodejs|

		nodejs.vm.network "private_network", ip: "192.168.33.11"

		nodejs.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "nodejs::install_from_binary"
			chef.add_recipe "nodejs::npm"

			chef.json = {
				:nodejs => {
					version: "0.10.6",
					checksum_linux_x64: "cc7ccfce24ae0ebb0c50661ef8d98b5db07fc1cd4a222c5d1ae232260d5834ca"
				}	
			}
		end
  	end

	config.vm.define "minecraft" do |minecraft|

		minecraft.vm.network "private_network", ip: "192.168.33.10"

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


