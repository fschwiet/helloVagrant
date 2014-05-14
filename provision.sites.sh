#!/bin/sh

if [ $(ps -e -o uid,cmd | grep $(id -u) | grep pm2 | grep -v grep | wc -l | tr -s "\n") -eq 0 ]
then
	cd /www; pm2 start hello-server.js
fi
