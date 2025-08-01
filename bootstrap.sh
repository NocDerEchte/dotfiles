#!/usr/bin/env bash
#
# Bootstrap a new machine


# Define colors for easier usage
RED='\e[32m'
NOCOLOR='\e[0m'

# Directories
DOTFILES_DIR="${HOME}/Repos/github.com/nocderechte/dotfiles"
XDG_BIN_HOME="${HOME}/.local/bin"

XDG_CACHE_HOME="${HOME}/.cache"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"


function _print_info() {
  local msg
  msg=$1

  echo -e "${msg}"
}

function _print_error() {
  local msg
  msg=$1

  echo -e "${RED}${msg}${NOCOLOR}"
}

function _ensure_non_root() {
  if [[ "${UID}" == 0 ]]; then
    _print_error 'Do not run this script as root or with sudo! The script will ask for permission if needed.'
  fi
}

function _create_dirs() {
  local dirs
  dirs=(
    "${XDG_BIN_HOME}"
    "${XDG_CACHE_HOME}"
    "${XDG_CONFIG_HOME}"
    "${XDG_DATA_HOME}"
    "${XDG_STATE_HOME}"
  )

  _print_info '== Checking for required directories =='

  for dir in "${dirs[@]}"; do

    [[ -d "${dir}" ]] || mkdir -p "${dir}" && _print_info "Created ${dir}"

  done
}

_link_configs() {
  local dotfiles_conf_dir xdg_config_home dir dir_name dest_dir

  dotfiles_conf_dir="${DOTFILES_DIR}/config"
  xdg_config_home="${XDG_CONFIG_HOME}"

  _print_info '== Creating symlinks for configs =='

  for dir in "${dotfiles_conf_dir}"/*; do
    if ! [[ -d "${dir}" ]]; then
      _print_info "${dir} is not a directory. Skipping."
      continue
    fi

    dir_name="$(basename "${dir}")"
    dest_dir="${xdg_config_home}/${dir_name}"

    if [[ -L "${dest_dir}" ]]; then
      _print_info "Unlinking ${dest_dir}"
      unlink "${dest_dir}"
    fi

    ln -sf "${dir}" "${dest_dir}"
    _print_info "Created symlink: ${dir} -> ${dest_dir}"
  done

  # Create symlink for .zshenv
  ln -sf "${DOTFILES_DIR}/.zshenv" "${HOME}/.zshenv"
}

function _link_fonts() {
  local dotfiles_fonts_dir xdg_fonts_home

  dotfiles_fonts_dir="${DOTFILES_DIR}/fonts"
  xdg_fonts_home="${XDG_DATA_HOME}/fonts"

  _print_info '== Creating symlinks for fonts =='

  # Ensure that xdg_fonts_home exists
  [[ -d "${xdg_fonts_home}" ]] || mkdir -p -- "${xdg_fonts_home}"

  # Create symlinks
  find "${dotfiles_fonts_dir}" -name "*.ttf" -exec ln -sf {} "$xdg_fonts_home" \; && _print_info 'Successfully created symlinks for fonts.'

  # Reload font cache
  fc-cache

}

function main() {

  _print_info ' _____        _    __ _ _'
  _print_info '|  __ \      | |  / _(_) |'
  _print_info '| |  | | ___ | |_| |_ _| | ___  ___'
  _print_info '| |  | |/ _ \| __|  _| | |/ _ \/ __|'
  _print_info '| |__| | (_) | |_| | | | |  __/\__ \'
  _print_info '|_____/ \___/ \__|_| |_|_|\___||___/'
  _print_info ''


  _print_info '=== Setup starting ==='
  _create_dirs
  _print_info ''
  source "${DOTFILES_DIR}/install.sh"
  _print_info ''
  _link_fonts
  _print_info ''
  _link_configs
  _print_info ''
  _print_info '=== Setup finished ==='
}

main
