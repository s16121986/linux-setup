#!/bin/bash

function wsi_run_installer {
  while :; do

    # find not installed
    array=()
    n=0
    for i in ${WSI_PACKAGES[@]}; do
#      if ! wsi_is_package_installed "${i}"; then
        array[n]=$i
        n=$((n + 1))
#      fi
    done

#    if [ $n -eq 0 ]; then
#      comment "All packages installed"
#      break
#    fi

    # echo
    title "Allowed packages:"
    n=0
    for i in ${array[@]}; do
      if [ $n -eq 0 ]; then
        dotted_line "* ${n}" "${i}"
      else
        dotted_line "  ${n}" "${i}"
      fi
      n=$((n + 1))
    done

    read -p "Press <enter> to keep the current choice[*], or type selection number: " i

    if [ -z ${i} ]; then
      i=0
    elif [ -z ${array[$i]} ]; then
      error "Wrong number"
      break
    fi

    wsi_install_package "${array[$i]}"

  done
}
