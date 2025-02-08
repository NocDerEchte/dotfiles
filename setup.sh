#!/usr/bin/bash


if [ ! -f "$PWD/setup.sh" ]; then
  printf 'Run this script directly and not like this: "./dir1/dir2/setup.sh"\nInstead use:"./setup.sh"\n'
  exit 1
fi

if [ $UID -eq 0 ]; then
  printf "Do not run this script as sudo or with the root user!\nThe script will ask for permission if needed.\n"
  exit 1
fi


link_files() {

  declare -r zsh_confdir=$HOME
  declare -r alacritty_confdir=$HOME"/.config/alacritty/"
  declare -r tmux_confdir=$HOME"/.config/tmux/"

  mkdir -p "$zsh_confdir"
  mkdir -p "$alacritty_confdir"
  mkdir -p "$tmux_confdir"

  ln -sf "$PWD/zsh/zshrc" "$zsh_confdir/.zshrc"
  ln -sf "$PWD/alacritty/alacritty.toml" "$alacritty_confdir/alacritty.toml"
  ln -sf "$PWD/tmux/tmux.conf" "$tmux_confdir/tmux.conf"

}

printf 'Starting package installation script.\nSudo rights required.\n'
sudo ./scripts/install_pkgs.sh

printf 'Starting oh-my-zsh setup.\n'
./scripts/setup_omz

link_files
