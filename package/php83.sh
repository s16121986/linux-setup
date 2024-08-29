#!/bin/bash

function wsi_install_php83 {
  wsi_ensure_package_installable php83 "PHP8.3 already installed"

  phpKey="php8.3"

  source "${WSI_LIB_PATH}/php-repository.sh"
  wsi_init_php_repository

  sudo apt -y -q install "${phpKey}-cli"
  sudo apt -y -q install "${phpKey}-common"
  sudo apt -y -q install "${phpKey}-opcache"
  sudo apt -y -q install "${phpKey}-mysqlnd"
  sudo apt -y -q install "${phpKey}-mcrypt"
  sudo apt -y -q install "${phpKey}-zip"
  sudo apt -y -q install "${phpKey}-xml"
  sudo apt -y -q install "${phpKey}-curl"
  sudo apt -y -q install "${phpKey}-mbstring"
  sudo apt -y -q install "${phpKey}-gd"
  sudo apt -y -q install "${phpKey}-soap"
  sudo apt -y -q install "${phpKey}-redis"
  sudo apt -y -q install "${phpKey}-memcached"
  sudo apt -y -q install "${phpKey}-fpm"

  sudo chown -R 1000:1000 /etc/php/8.3/fpm

  sudo systemctl enable php8.3-fpm
}
