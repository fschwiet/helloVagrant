
nothing: /tmp/vagrant-chef-3/chef-solo-1/cookbooks => /Users/user/.berkshelf/nothing/vagrant/berkshelf-20140615-21141-5qyui4-nothing

Failed to mount folders in Linux guest. This is usually because
the "vboxsf" file system is not available. Please verify that
the guest additions are properly installed in the guest and
can work properly. The command attempted was:

mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` v-csc-1 /tmp/vagrant-chef-3/chef-solo-1/cookbooks
mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` v-csc-1 /tmp/vagrant-chef-3/chef-solo-1/cookbooks



Requirements
	vagrant plugin install vagrant-omnibus  		# for installing chef-solo
	vagrant plugin install vagrant-secret   		# for managing secrets in an external config file
	vagrant plugin install vagrant-digitalocean  	# for deploying to DigitalOcean
	vagrant plugin install vagrant-berkshelf --plugin-version '>=2.0.1'
	    (which needed, on mac: gem install vagrant-vbguest)

	rsync - 
		- for windows, run Cygwin's c:\Cygwin\cygwinsetup.exe and add rsync
		- rsync needs to be in current path

Reboot is needed for some changes to kick in:
  - Nginx configuration change
  - fail2ban activation  (perhaps instead there is latency before the ssh login kicks in)
Maybe reboot after provision with https://github.com/exratione/vagrant-provision-reboot


Could use a better vagrant box
  that matches OS version for DigitalOcean
  Needs Ruby 1.9
  Needs Chef 11
  Prefer to have chef-solo provisioner installed (for now, it isn't)


minor: nginx .config loses its newlines

minor: Minecraft server not reliable



cookbooks used:

	https://github.com/opscode-cookbooks/mysql

	https://github.com/mdxp/nodejs-cookbook
		https://github.com/opscode-cookbooks/build-essential
		https://github.com/cookbooks/apt
		https://github.com/opscode-cookbooks/yum-epel

	https://github.com/txus/minecraft-cookbook

	https://github.com/opscode-cookbooks/nginx
		https://github.com/opscode-cookbooks/build-essential
		https://github.com/opscode-cookbooks/ohai
		https://github.com/opscode-cookbooks/bluepill		
			https://github.com/opscode-cookbooks/rsyslog
		https://github.com/hw-cookbooks/runit
		??
			https://github.com/opscode-cookbooks/yum

	Wordpress - https://github.com/brint/wordpress-cookbook
		mysql
		mysql-chef_gem - https://github.com/opscode-cookbooks/mysql-chef_gem
		php - https://github.com/opscode-cookbooks/php
			build-essential
			xml - https://github.com/opscode-cookbooks/xml
			mysql
		apache2 - https://github.com/onehealth-cookbooks/apache2
		iis - really? - https://github.com/opscode-cookbooks/iis
		windows - really? - https://github.com/opscode-cookbooks/windows
		openssl - https://github.com/opscode-cookbooks/openssl
		?? iptables - https://github.com/opscode-cookbooks/iptables
		?? pacman - https://github.com/jesseadams/pacman
		?? database - https://github.com/opscode-cookbooks/database
		?? aws - https://github.com/opscode-cookbooks/aws


subtree notes: don't forget to squash!  IE:
    git subtree add --prefix cookbooks/ohai https://github.com/opscode-cookbooks/ohai master --squash		