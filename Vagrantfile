# -*- mode: ruby -*-
# vi: set ft=ruby :


def enableFirewall(vm)

	firewallConfig = <<-EOS
		sudo apt-get install -y ufw
		sudo ufw default deny incoming
		sudo ufw default allow outgoing


		sudo ufw allow 21/tcp    #ftp, used by wget during some provisioning
		sudo ufw allow 22/tcp    #ssh

		sudo ufw allow 80/tcp    #www
		sudo ufw allow 8080/tcp  #www testing
		sudo ufw allow 8081/tcp  #www testing
		sudo ufw allow 8082/tcp  #www testing
		sudo ufw allow 3306/tcp  #mysql

		sudo echo yes | ufw enable
		sudo ufw status verbose
	EOS

	vm.provision "shell", inline: firewallConfig
end

def protectSshFromLoginAttacks(vm)
	vm.provision "shell", inline: <<-EOS
		sudo apt-get install -y fail2ban; 
		sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local; 
		sudo service fail2ban restart
	EOS
end

def aptgetUpdate(vm)
	vm.provision :chef_solo do |chef|
		chef.cookbooks_path = "cookbooks"
		chef.add_recipe "apt"
	end
end

def installGit(vm)
	vm.provision "shell", inline: "sudo apt-get install -y git"
end


Vagrant.configure("2") do |config|

	config.vm.box = "opscode-ubuntu-14.04"
	config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

	config.omnibus.chef_version = :latest

	aptgetUpdate config.vm

	enableFirewall config.vm

	protectSshFromLoginAttacks config.vm

	config.vm.provision "shell", inline: "echo 'set nocp' > /home/vagrant/.vimrc"

	config.vm.define "nothing" do |nothing|
	end

	config.vm.define "biggy" do |biggy|

		biggy.vm.network "private_network", ip: "192.168.33.15"

		installGit biggy.vm

		installMysql biggy.vm, "password"
		installNodejs biggy.vm
		installNginx biggy.vm

		deploySites biggy.vm
		configureNodeToAlwaysRunSites biggy.vm
		writeNginxProxyRule biggy.vm, "127.0.0.1", 8080
	end

	config.vm.define "nginx" do |nginx|

		nginx.vm.network "private_network", ip: "192.168.33.14"

		installNginx nginx.vm
		writeNginxProxyRule nginx.vm, "192.168.33.11", 8080
	end

  	config.vm.define "mysql" do |mysql|
  		
		mysql.vm.network "private_network", ip: "192.168.33.13"

		installMysql mysql.vm, "password"
  	end

	config.vm.define "apache" do |apache|

		apache.vm.network "private_network", ip: "192.168.33.12"

		apache.vm.provision "shell", path: "provision.apache.sh"
  	end


	config.vm.define "nodejs" do |nodejs|

		nodejs.vm.network "private_network", ip: "192.168.33.11"

		installNodejs nodejs.vm
		deploySites nodejs.vm
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

	def deploySites(vm)

		vm.provision "shell", inline: "sudo mkdir /sites; sudo chown vagrant /sites;"
		vm.provision "shell", inline: "sudo mkdir /sites/www; cp /vagrant/src/server/hello-server.js /sites/www"

		vm.provision "shell", inline: "cp /vagrant/provision.sites.sh /sites"
		vm.provision "shell", inline: "cp /vagrant/src/server/hello-server.js /sites/www"
	end

	def installNodejs(vm)

		vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "nodejs::install_from_binary"
			chef.add_recipe "nodejs::npm"

			chef.json = {
				:nodejs => {
					#version: "0.10.6",
 					#checksum_linux_x64: "cc7ccfce24ae0ebb0c50661ef8d98b5db07fc1cd4a222c5d1ae232260d5834ca"
					#version: "0.11.10",
					#checksum_linux_x64: "5397e1e79c3052b7155deb73525761e3a97d5fcb0868d1e269efb25d7ec0c127"
				}	
			}
		end
	end

	def installMysql(vm, rootPassword)

		vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "mysql::server"

			chef.json = {
				:mysql => {

					server_root_password: rootPassword,

					version: '5.6',
					port: '3306',
					data_dir: '/data-mysql',
					allow_remote_root: true,
					remove_anonymous_Users: true,
					remove_test_database: true
				}
			}
		end		
	end

	def installNginx(vm)
		vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cookbooks"
			chef.add_recipe "nginx"
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


