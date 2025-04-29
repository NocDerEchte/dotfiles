#!/usr/bin/bash
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

function _install_bins() {

  _print_info '== Downloading binaries =='

  if ! [[ $(which oh-my-posh) ]]; then
    { curl https://cdn.ohmyposh.dev/releases/latest/posh-linux-amd64 --output "${xdg_bin_home}"/oh-my-posh && \
      chmod +x "${xdg_bin_home}/oh-my-posh" && \
      _print_info 'Successfully installed oh-my-posh.'; } || _print_error 'Failed insatalling oh-my-posh.'
  else
    _print_info 'Skipping oh-my-posh. Already installed.'
  fi

  if ! [[ $(which helm) ]]; then
    { HELM_INSTALL_DIR="$xdg_bin_home" bash -c 'https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3' && \
      _print_info 'Successfully installed helm.'; } || _print_error 'Failed insatalling helm.'
  else
    _print_info 'Skipping helm. Already installed.'
  fi

  if ! [[ $(which kubectl) ]]; then
    { curl -LO "https://dl.k8s.io/release/$(curl -LS https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" --output-dir "${xdg_bin_home}" && \
      chmod +x "${xdg_bin_home}/kubectl" && \
      _print_info 'Successfully installed kubectl.'; } || _print_error 'Failed insatalling kubectl.'
  else
    _print_info 'Skipping kubectl. Already installed.'
  fi

}

function _install_zap() {
  _print_info '== Installing zap =='

  if ! [[ -f  "${xdg_data_home}/zap/zap.zsh" ]]; then
    { zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1 && \
      _print_info 'Successfully installed zap.'; } || _print_error 'Failed insatalling zap.'
  fi
}

main() {
  local xdg_bin_home xdg_data_home

  xdg_bin_home="${XDG_BIN_HOME:-$HOME/.local/bin}"
  xdg_data_home="${XDG_DATA_HOME:-$HOME/.local/share}"

  _install_pkgs
  _print_info ''

  _install_zap
  _print_info ''

  _install_bins

}

main
