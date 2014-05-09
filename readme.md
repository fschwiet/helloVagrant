need to pick a base box.
  Needs Ruby 1.9
  Needs Chef 11
  Prefer to have chef-solo provisioner installed (for now, it isn't)
  would like something production grade

requires vagrant-omnibus vagrant plugin, run: 

	vagrant plugin install vagrant-omnibus

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

subtree notes: don't forget to squash!  IE:
    git subtree add --prefix cookbooks/ohai https://github.com/opscode-cookbooks/ohai master --squash		