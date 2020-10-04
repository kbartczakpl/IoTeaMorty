#!/bin/bash

readonly NAME="nextcloud"
readonly IMAGE="nextcloud"


docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}


docker create \
   --name=${NAME} \
   --link mariadb \
   -p 980:80 \
   -v /media/docker/storage/${NAME}/apps:/var/www/html/apps \
   -v /media/docker/storage/${NAME}/config:/var/www/html/config \
   -v /media/docker/${NAME}/data:/var/www/html/data \
   ${IMAGE}

docker start ${NAME}
