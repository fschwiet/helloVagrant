#!/bin/sh

# note:  limited environment variables available within this crontab script.
#   In particular, $PATH is not set.

if [ $(ps -e -o cmd | grep pm2 | grep hello-server | grep -v grep | wc -l | tr -s "\n") -eq 0 ]
then
	cd /sites/www; /usr/local/bin/pm2 start hello-server.js --user wwwuser
fi
