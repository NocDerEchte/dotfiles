#!/usr/bin/bash

if [ ! $UID -eq 0 ]; then
  printf 'Permission denied\nrun this script as root or with sudo!\n'
  exit 1
fi


install_packages() {
  local base_pkgs=(
    git
    curl
    zsh
    tmux
    bat
    fzf
    zoxide
  )

  local extra_pkgs=(
    code
    spotify-client
    steam
    chrome
  )


  printf "\\b--- Base packages ---\n"
  printf "\\b - %s\n" "${base_pkgs[@]}"
  read -r -p 'Install all packages in this list? [Y/n]' input

  if [[ $input == "n" || $input == "N" ]]; then
    printf "Skipping\n\n"
  else
    sudo apt install -y "${base_pkgs[@]}"
    printf '\n\n'
  fi


  printf "\\b--- Extra packages ---\n"
  printf "\\b - %s\n" "${extra_pkgs[@]}"
  read -r -p 'Install all packages in this list? [Y/n]' input

  if [[ $input == "n" || $input == "N" ]]; then
    printf "Skipping\n\n"
  else
    sudo apt install -y "${base_pkgs[@]}"
    printf '\n\n'
  fi

  exit 0
}


install_packages
