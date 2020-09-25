#!/bin/bash

readonly HOST="cloud.bartczak.eu"
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
   -v /media/docker/storage/${NAME}/apps:/var/www/html/apps \
   -v /media/docker/storage/${NAME}/config:/var/www/html/config \
   -v /media/:/var/www/html/data \
   -e MYSQL_DATABASE=/run/secrets/db_database \
   -e MYSQL_USER=/run/secrets/db_user \
   -e MYSQL_PASSWORD=/run/secrets/db_password \
   -e MYSQL_HOST=/run/secrets/db_host \
   ${IMAGE}

docker start ${NAME}
