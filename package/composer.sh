#!/bin/bash

ROOT_PATH=$(dirname $(dirname "${0}"))

source "${ROOT_PATH}/lib/echo.sh"

if [ ! -f /usr/local/bin/composer ]; then
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php
  php -r "unlink('composer-setup.php');"

  sudo mv composer.phar /usr/local/bin/composer
#chmod 0660 /usr/local/bin/composer
else
  skipped "Composer already installed"
fi
