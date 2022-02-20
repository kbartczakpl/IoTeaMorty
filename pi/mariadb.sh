#!/bin/bash

readonly NAME="mariadb_10_2"
readonly IMAGE="mariadb:10.2"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}

docker create \
   --name=${NAME} \
   -e MYSQL_ROOT_PASSWORD_FILE=/secrets/mariadb/root_password \
   -v $(pwd)/run/secrets:/secrets \
   -v /media/docker/${NAME}/mysql:/var/lib/mysql \
   -v /media/docker/${NAME}/conf:/etc/mysql/conf.d \
   -p 3306:3306 \
   --restart unless-stopped \
   ${IMAGE}

docker start ${NAME}
