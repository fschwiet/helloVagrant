



Requirements
	vagrant plugin install vagrant-omnibus  		# for installing chef-solo
	vagrant plugin install vagrant-secret   		# for managing secrets in an external config file
	vagrant plugin install vagrant-digitalocean  	# for deploying to DigitalOcean

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


subtree notes: don't forget to squash!  IE:
    git subtree add --prefix cookbooks/ohai https://github.com/opscode-cookbooks/ohai master --squash		