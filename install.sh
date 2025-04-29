#!/usr/bin/env bash
#
# Install desired packages


function _install_pkgs() {
  local pkgs
  pkgs=(
    fzf
    zsh
    tmux
  )
  _print_info '== Installing required packages =='
  sudo apt-get update && sudo apt-get -y install "${pkgs[@]}"
}

function _install_misc() {

  if ! [[ -f  "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ]]; then
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 && \
    _print_info 'Successfully installed zap.'
  fi
}

_install_pkgs
_install_misc
