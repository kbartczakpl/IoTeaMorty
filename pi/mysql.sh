#!/bin/bash

readonly NAME="mysql"
readonly IMAGE="mysql:latest"

docker pull ${IMAGE}

docker stop ${NAME}
docker rm ${NAME}


P_PASS=""

echo "$(tput setaf 1)Podaj hasło uzytkownika root:$(tput sgr 0)"
read P_PASS


docker create \
   --name=${NAME} \
   -e MYSQL_ROOT_PASSWORD=/run/secrets/MYSQL_ROOT_PASSWORD \
   -d ${IMAGE}

docker start ${NAME}

