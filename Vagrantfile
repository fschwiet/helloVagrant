# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	config.vm.box = "opscode-ubuntu-14.04"
	config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

	config.omnibus.chef_version = :latest

	config.vm.provision "shell", inline: "echo 'set nocp' > /home/vagrant/.vimrc"

	config.vm.define "biggy" do |biggy|

		biggy.vm.network "private_network", ip: "192.168.33.15"

		biggy.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "nginx"
			chef.add_recipe "nodejs::install_from_binary"
			chef.add_recipe "nodejs::npm"			
			chef.add_recipe "mysql::server"

			chef.json = {
				:nodejs => {
					version: "0.10.6",
					checksum_linux_x64: "cc7ccfce24ae0ebb0c50661ef8d98b5db07fc1cd4a222c5d1ae232260d5834ca"
				},
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

		biggy.vm.provision "shell",
			inline: "sudo npm install forever -g"

		# WHEN / HOW ARE CONFIG FILES COPIED?

		# WHEN DO MIGRATIONS RUN?

		biggy.vm.provision "shell",
			inline: "echo -e $1 > /etc/nginx/conf.d/firstServer.conf",
			args: [<<-EOS
				server {
					listen *:80;
					location ~ ^/ {
					    proxy_pass http://127.0.0.1:8080;
					}
				}
			EOS
			]

		# forever seems not to start after vagrant reload, maybe use PM2: https://github.com/Unitech/pm2#a8

		biggy.vm.provision "shell",
			inline: "forever start --uid $1 --sourceDir $1 $2",
			args: ["/vagrant/src/server", "hello-server.js"]

	end

	config.vm.define "nginx" do |nginx|

		nginx.vm.network "private_network", ip: "192.168.33.14"

		nginx.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "nginx"
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

		nginx.vm.provision "shell", inline: "sudo service nginx restart"
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

		nodejs.vm.provision "shell", inline: "sudo npm install forever -g"
		nodejs.vm.provision "shell", inline: "forever start --sourceDir /vagrant/src/server hello-server.js"
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


