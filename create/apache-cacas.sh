#!/bin/bash

PR_NAME="cacas"
HOSTNAME="cacas.bartczak.eu"

EXTS=$(cat /home/docker/create/bin/apache-ext | tr '\n' ' ')


#echo "$(tput setaf 1)Podaj nazwę projektu $(tput setab 3)(nazwa kontenera i folderu w www):$(tput sgr 0)"
#read PR_NAME

#echo "$(tput setaf 1)Podaj hosty pod jakimi będzie dostępny projekt $(tput setab 3)(jeśli wiele po przecinku)$(tput sgr 0):"
#read PR_HOSTS

mkdir /data/www/cacas
chown -R kbartczak:kbartczak /data/www/cacas

docker create \
  --name cacas \
  --link mysql \
   -e VIRTUAL_HOST=${HOSTNAME} \
   -e HTTPS_METHOD=redirect \
   -e LETSENCRYPT_HOST=${HOSTNAME} \
   -e LETSENCRYPT_EMAIL=admin@${HOSTNAME} \
  --expose 80 \
  -v "/data/www/"cacas:/var/www/html \
  -v "/data/cloud.bartczak.eu/kbartczak/files/cacas/":/var/www/html/storage \
  php:5.6-apache


docker start cacas

docker exec cacas /bin/sh -c "apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev && docker-php-ext-install iconv mcrypt && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd"

docker restart cacas
