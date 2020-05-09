#!/bin/bash

readonly HOST="cloud2.bartczak.eu"
readonly NAME="nextcloud"
readonly IMAGE="nextcloud"


docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}


docker create \
   --name=${NAME} \
   -e VIRTUAL_HOST=${HOST} \
   -e HTTPS_METHOD=redirect \
   -e LETSENCRYPT_HOST=${HOST} \
   -e LETSENCRYPT_EMAIL=admin@${HOST} \
   --expose 80 \
   -v /home/docker/storage/${NAME}/apps:/var/www/html/apps \
   -v /home/docker/storage/${NAME}/config:/var/www/html/config \
   -v /data/${NAME}:/var/www/html/data \
   ${IMAGE}

docker start ${NAME}
