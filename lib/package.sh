#!/bin/bash

function _package_exists {
  if [ -z $(which "${1}") ]; then
    return 1
  else
    return 0
  fi
}

function _file_exists {
  if [ -f "${1}" ]; then
    return 0
  else
    return 1
  fi
}

function wsi_is_package_installed {
  case "${1}" in
  "composer")
    return $(_file_exists "/usr/local/bin/composer")
    ;;
  "git")
    return $(_file_exists "$HOME/.gitconfig")
    ;;
  "php")
    return $(_file_exists "/usr/bin/php")
    ;;
  "php74")
    return $(_file_exists "/usr/bin/php7.4")
    ;;
  "php81")
    return $(_file_exists "/usr/bin/php8.1")
    ;;
  "php82")
    return $(_file_exists "/usr/bin/php8.2")
    ;;
  "php83")
    return $(_file_exists "/usr/bin/php8.3")
    ;;
  "nginx")
    return $(_package_exists "nginx")
    ;;
  "mysql")
    return $(_package_exists "mariadb")
    ;;
  "memcached")
    return $(_package_exists "memcached")
    ;;
  "redis")
    return $(_package_exists "redis-cli")
    ;;
  "supervisor")
    return $(_package_exists "supervisord")
    ;;
  "docker")
    return $(_package_exists "docker")
    ;;
  "volta")
    return $(_file_exists "$HOME/.volta/bin/volta")
    ;;
  "phpmyadmin")
    return $(_file_exists "/etc/nginx/conf.d/phpmyadmin.conf")
    ;;
  *)
    return 1
    ;;
  esac
}

function wsi_ensure_package_installable {
  if wsi_is_package_installed "${1}"; then
    echo -e "Package [${1}] already installed: ${GRAY}SKIPPED${NC}"
    exit
  fi
}

function wsi_install_package {
  if [ -f "${WSI_PACKAGE_PATH}/${1}.sh" ]; then
    source "${WSI_PACKAGE_PATH}/${1}.sh"
    #wsi_composer
    eval "wsi_install_${1}"
    #bash -c "wsi_${1}"
    #"$ROOT_PATH/bin/${v}.sh"
  else
    error "Package ${1} not found"
  fi
}
