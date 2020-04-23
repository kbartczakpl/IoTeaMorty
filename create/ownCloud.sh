#!/bin/bash

docker create \
   --name=ownCloud \
   --link mysql:mysql \
   -p 82:80 \
   -e VIRTUAL_HOST=cloud.bartczak.ovh,cloud.yass \
   -v /home/docker/storage/ownCloud/apps:/var/www/html/apps \
   -v /home/docker/storage/ownCloud/config:/var/www/html/config \
   -v /data/cloud:/var/www/html/data \
   owncloud:latest

