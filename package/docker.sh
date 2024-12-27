#!/bin/bash

function wsi_install_docker() {
  wsi_ensure_package_installable docker "Docker already installed"

  # shellcheck disable=SC2155
  local distrib="debian"

  # Add Docker's official GPG key:
  sudo apt-get -yqq update
  sudo apt-get -y install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL "https://download.docker.com/linux/$distrib/gpg" -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$distrib \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get -yqq update

  sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  if [ -z "$(getent group docker)" ]; then
    sudo groupadd docker
  fi

  sudo usermod -aG docker "$USER"
}
