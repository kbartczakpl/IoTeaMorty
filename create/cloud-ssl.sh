#!/bin/bash

readonly HOST="cloud.bartczak.eu"
readonly NAME="cloud"

docker create \
   --name=${NAME} \
   -e VIRTUAL_HOST=${HOST} \
   -e HTTPS_METHOD=redirect \
   -e LETSENCRYPT_HOST=${HOST} \
   -e LETSENCRYPT_EMAIL=admin@${HOST} \
   --expose 80 \
   -v /home/docker/storage/${HOST}/apps:/var/www/html/apps \
   -v /home/docker/storage/${HOST}/config:/var/www/html/config \
   -v /data/${HOST}:/var/www/html/data \
    owncloud:latest

docker start ${NAME}
