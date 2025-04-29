#!/usr/bin/env zsh
#
# zsh environment file: loaded always

export ZDOTDIR="${HOME}/.config/zsh"

# xdg standardized paths
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"

# Ensure all directories exist
() {
  local dir
  for dir in $@; do
    [[ -d "${(P)dir}" ]] || mkdir -p -- "${(P)dir}"
  done
} ZDOTDIR XDG_{CONFIG,DATA,CACHE,STATE}_HOME
