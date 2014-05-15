review this: https://www.digitalocean.com/community/articles/how-to-host-multiple-node-js-applications-on-a-single-vps-with-nginx-forever-and-crontab
review security concerns: https://www.digitalocean.com/community/questions/how-do-you-secure-your-new-server



why is vagrant reload nginx still needed?


try to include newlines in the nginx.conf


Could use a better box
  that matches OS version for DigitalOcean
  Needs Ruby 1.9
  Needs Chef 11
  Prefer to have chef-solo provisioner installed (for now, it isn't)
  would like something production grade


This Vagranfile uses chef-solo installed by omnibus, so vagrant-omnibus must be installed, you can run: 
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