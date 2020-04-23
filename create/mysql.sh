#!/bin/bash

P_PASS=""

echo "$(tput setaf 1)Podaj hasło uzytkownika root:$(tput sgr 0)"
read P_PASS

docker create --name mysql -e MYSQL_ROOT_PASSWORD=$P_PASS mysql:8.0.0

