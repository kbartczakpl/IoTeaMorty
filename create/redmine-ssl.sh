#!/bin/bash


readonly HOST="redmine.bartczak.eu"
readonly NAME="redmine"

docker create \
  --name=mysql-redmine  \
  --env='DB_NAME=redmine_kb' \
  --env='DB_USER=redmine' --env='DB_PASS=579128' \
  --volume=/home/docker/storage/redmine/mysql:/var/lib/mysql \
  sameersbn/mysql:latest

docker start mysql-redmine
  

docker create \
   --name=${NAME} \
   -e VIRTUAL_HOST=${HOST} \
   -e HTTPS_METHOD=redirect \
   -e LETSENCRYPT_HOST=${HOST} \
   -e LETSENCRYPT_EMAIL=admin@${HOST} \
   -it --rm --link=mysql-redmine:mysql \
   --env='SMTP_USER=no-replay@bartczak.eu' --env='SMTP_PASS=CI2D1ven5rbj5gEQ4PTvorfXpJSlAQ' \
   --env='SMTP_DOMAIN=bartczak.eu' \
   --volume=/home/docker/storage/redmine/redmine:/home/redmine/data \
   --expose 80 \
   sameersbn/redmine:latest

docker start ${NAME}
