#!/bin/bash

# Setup php repository

function wsi_init_php_repository {
  local distrib=$(detect_linux_distrib)
  case "$distrib" in
  "debian")
    if [ -f /etc/apt/sources.list.d/php.list ]; then
      return 0
    fi

    sudo apt -y install apt-transport-https lsb-release ca-certificates wget
    local php_proxy="https://ftp.mpi-inf.mpg.de/mirrors/linux/mirror/deb.sury.org/repositories/php/"
    sudo cp "$WSI_ROOT_PATH/conf/php/apt.gpg" /etc/apt/trusted.gpg.d/php.gpg
    echo "deb $php_proxy $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
    #sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
    #sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
    ;;
  "ubuntu")
    if [ ! -z "$(apt-cache policy | grep "ondrej/php")" ]; then
      return 0
    fi

    sudo add-apt-repository -y ppa:ondrej/php
    sudo apt -yqq update
    ;;
  esac

  return 0
}

function detect_linux_distrib {
  echo $(grep -ioP '^ID=\K.+' /etc/os-release)
}
