#!/bin/bash

readonly NAME="mariadb"
readonly IMAGE="mariadb:tag"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e MYSQL_ROOT_PASSWORD=/run/secrets/MYSQL_ROOT_PASSWORD \
   -e MYSQL_USER=/run/secrets/MYSQL_USER \
   -v /media/docker-storage/${NAME}:/var/lib/mysql
   ${IMAGE}

docker start ${NAME}