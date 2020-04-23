#!/bin/bash

PR_NAME=""
PR_HOSTS=""

EXTS=$(cat /home/docker/create/bin/apache-ext | tr '\n' ' ')


echo "$(tput setaf 1)Podaj nazwę projektu $(tput setab 3)(nazwa kontenera i folderu w www):$(tput sgr 0)"
read PR_NAME

echo "$(tput setaf 1)Podaj hosty pod jakimi będzie dostępny projekt $(tput setab 3)(jeśli wiele po przecinku)$(tput sgr 0):"
read PR_HOSTS

mkdir /data/www/$PR_NAME
chown -R kbartczak:kbartczak /data/www/$PR_NAME

docker create \
  --name $PR_NAME \
  --link mysql \
  -e VIRTUAL_HOST=$PR_HOSTS \
  --expose 80 \
  -v "/data/www/"$PR_NAME:/var/www/html \
  php:5.6-apache

read -p "Uruchomic kontener i zainstalować rozszerzenia?[Y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then

docker start $PR_NAME

docker exec $PR_NAME /bin/sh -c "apt-get update && apt-get -y install libssl-dev libjpeg-dev libpng12-dev libicu-dev libxml2-dev libmcrypt-dev && touch /usr/local/etc/php/php.ini && /usr/local/bin/docker-php-ext-install $EXTS"

docker exec $PR_NAME a2enmod rewrite

docker restart $PR_NAME

fi
