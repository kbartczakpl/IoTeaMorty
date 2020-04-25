#!/bin/bash

sudo service apache2 stop

docker start nginx-letsencrypt
docker start nginx-reverse-proxy
docker start ui
docker start emby
docker start mysql
docker start myadmin
docker start bartczak-eu-ssl
docker start intro
docker start dev
docker start api
docker start cacas
docker start cloud
#./../docker/create/redmine-ssl.sh
