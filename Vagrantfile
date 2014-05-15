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
			inline: "sudo npm install pm2 -g"

		# WHEN / HOW ARE CONFIG FILES COPIED?

		# WHEN DO MIGRATIONS RUN?

		writeNginxProxyRule biggy.vm, "127.0.0.1", 8080
		configureNodeToAlwaysRunSites biggy.vm
	end

	config.vm.define "nginx" do |nginx|

		nginx.vm.network "private_network", ip: "192.168.33.14"

		nginx.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "nginx"
		end

		writeNginxProxyRule nginx.vm, "192.168.33.11", 8080
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
					version: "0.11.10",
					checksum_linux_x64: "5397e1e79c3052b7155deb73525761e3a97d5fcb0868d1e269efb25d7ec0c127"
				}	
			}
		end

		# create a directory for the website (/www) and logs (/log)
		nodejs.vm.provision "shell", inline: "sudo mkdir /sites; sudo chown vagrant /sites;"
		nodejs.vm.provision "shell", inline: "sudo mkdir /sites/www; cp /vagrant/src/server/hello-server.js /sites/www"

		nodejs.vm.provision "shell", inline: "cp /vagrant/provision.sites.sh /sites"
		nodejs.vm.provision "shell", inline: "cp /vagrant/src/server/hello-server.js /sites/www"

		configureNodeToAlwaysRunSites nodejs.vm
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

	def writeNginxProxyRule(vm, ipAddress, port)

		nginxConfig = <<-EOS
			server {
					listen 80;

					location ~ ^/ {
					    proxy_pass http://$IP_ADDRESS:$PORT;

				        proxy_http_version 1.1;
				        proxy_set_header Upgrade \\$http_upgrade;
				        proxy_set_header Connection 'upgrade';
				        proxy_set_header Host \\$host;
				        proxy_cache_bypass \\$http_upgrade;
					}
				}
			EOS

		nginxConfig = nginxConfig.gsub("$IP_ADDRESS", ipAddress)
		nginxConfig = nginxConfig.gsub("$PORT", port.to_s)

		vm.provision "shell", 
			inline: "echo -e $1 > /etc/nginx/conf.d/firstServer.conf", args: [ nginxConfig ]

		## force nginx to reload configuration
		  #vm.provision "shell", inline: " pid=$(cat /var/run/nginx.pid); sudo kill -HUP $pid"
		    # failed with cat: /var/run/nginx.pid: No such file or directory

		  #vm.provision "shell", inline: 'sudo service nginx start'
		    # seems to have no effect
	end


	def configureNodeToAlwaysRunSites(vm)
		vm.provision "shell", inline: "sudo npm install pm2 -g"
		vm.provision "shell", inline: "(crontab -l ; echo '@reboot /sites/provision.sites.sh') | crontab"
		vm.provision "shell", inline: "/sites/provision.sites.sh"		
	end

end


