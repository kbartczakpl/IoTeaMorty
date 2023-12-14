#!/bin/bash

readonly NAME="proxy-manager"
readonly IMAGE="jc21/nginx-proxy-manager:latest"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   --link mariadb:mariadb \
   -v $(pwd)/run/config/proxy-manager/config.json:/app/config/production.json \
   -v /media/docker/${NAME}/data:/data \
   -v /media/docker/${NAME}/letsencrypt:/etc/letsencrypt \
   -p 80:80 \
   -p 81:81 \
   -p 443:443 \
   --restart unless-stopped \
   ${IMAGE}

docker start ${NAME}
