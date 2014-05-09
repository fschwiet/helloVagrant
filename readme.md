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

subtree notes: don't forget to squash!  IE:
    git subtree add --prefix cookbooks/ohai https://github.com/opscode-cookbooks/ohai master --squash		