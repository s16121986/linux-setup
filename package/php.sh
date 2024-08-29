#!/bin/bash

function wsi_install_php {
  VERSIONS=("8.3" "8.2" "8.1" "7.4")

  title "Choose PHP version to install:"

  n=0
  for i in ${VERSIONS[@]}; do
    if [ $n -eq 0 ]; then
      dotted_line "* ${n}" "${i}"
    else
      dotted_line "  ${n}" "${i}"
    fi
    n=$((n + 1))
  done

  read -p "Press <enter> to keep the current choice[*], or type selection number: " v

  if [ -z $v ]; then
    v=0
  fi

  n=$(sed "s/\.//g" <<<"${VERSIONS[v]}")

  wsi_install_package "php${n}"
}
