#!/bin/bash

PR_NAME=""
PR_HOSTS=""
PR_DIR=""
PR_PHP="5.6"

EXTS=$(cat /home/docker/create/bin/apache-ext | tr '\n' ' ')

echo "$(tput setaf 1)Podaj nazwę projektu $(tput setab 3)(nazwa kontenera):$(tput sgr 0)"
read PR_NAME

echo "$(tput setaf 1)Podaj host(bez wildcard) pod jakimi będzie dostępny projekt $(tput sgr 0):"
read PR_HOSTS

echo "$(tput setaf 1)Podaj nazwę folderu montowania $(tput sgr 0):"
read PR_DIR

echo "$(tput setaf 1)Podaj wersję PHP $(tput setab 3)[domyślnie 5.6, opcjonlanie 7.1] $(tput sgr 0):"
read PR_PHP

mkdir /data/www/$PR_DIR
mkdir /data/www/$PR_DIR/config/
mkdir /data/www/$PR_DIR/public_html/
cp -R /home/docker/create/bin/apache-template/hosts.conf /data/www/$PR_DIR/config/

chown -R kbartczak:kbartczak /data/www/$PR_DIR

docker create \
  --name $PR_NAME \
  --link mysql \
  -e VIRTUAL_HOST=$PR_HOSTS \
  -e HTTPS_METHOD=redirect \
  -e LETSENCRYPT_HOST=$PR_HOSTS \
  -e LETSENCRYPT_EMAIL=admin@$PR_HOSTS \
  --expose 80 \
  -v "/data/www/"$PR_DIR:/var/www/html \
  php:$PR_PHP-apache

read -p "Uruchomic kontener i zainstalować rozszerzenia?[Y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then

docker start $PR_NAME

docker exec $PR_NAME /bin/sh -c "ln -s /var/www/html/config/hosts.conf /etc/apache2/sites-available/routing.conf && a2ensite routing && service apache2 reload"

docker exec $PR_NAME /bin/sh -c "apt-get update && apt-get -y install libssl-dev libjpeg-dev libpng12-dev libicu-dev libxml2-dev libmcrypt-dev && touch /usr/local/etc/php/php.ini && /usr/local/bin/docker-php-ext-install $EXTS"

docker exec $PR_NAME a2enmod rewrite

docker restart $PR_NAME

fi
