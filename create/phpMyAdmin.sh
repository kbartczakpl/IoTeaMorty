#!/bin/bash

readonly HOST="myadmin.bartczak.eu"
readonly NAME="myadmin"

docker create \
   --name=${NAME} \
   -e VIRTUAL_HOST=${HOST} \
   -e HTTPS_METHOD=redirect \
   -e LETSENCRYPT_HOST=${HOST} \
   -e LETSENCRYPT_EMAIL=admin@${HOST} \
   --expose 80 \
   --link mysql:db \
   -p 8080:80 phpmyadmin/phpmyadmin

docker start ${NAME}
