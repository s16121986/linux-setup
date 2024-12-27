#!/bin/bash

function wsi_install_composer {
  wsi_ensure_package_installable composer "Composer already installed"

  sudo apt -yqq install unzip

  # shellcheck disable=SC2155
  local EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  # shellcheck disable=SC2155
  local ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
    io::error "ERROR: Invalid installer checksum"
    rm composer-setup.php
    return
  fi

  php composer-setup.php --quiet
  local RESULT=$?
  rm composer-setup.php
  sudo mv composer.phar /usr/local/bin/composer
  if [ $RESULT != 0 ]; then
    io::error "Composer installation failed"
    return 1
  fi
}
