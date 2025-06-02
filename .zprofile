#!/usr/bin/env zsh
#
# general env vars set on login.

# xdg standardized paths
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_BIN_HOME="${HOME}/.local/bin"

# ensure all directories exist
() {
  local dir
  for dir in $@; do
    [[ -d "${(P)dir}" ]] || mkdir -p -- "${(P)dir}"
  done
} XDG_{CONFIG,DATA,CACHE,STATE,BIN}_HOME

# default programs
export EDITOR='code --wait'

# custom zsh dir
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# dotfiles repo location
export DOTFILES_DIR="${HOME}/Repos/github.com/nocderechte/dotfiles"

# add custom scripts to PATH
export PATH=$PATH:$DOTFILES_DIR/scripts

# load custom aliases
source "${XDG_CONFIG_HOME}/shell/aliases"

# fzf color settings
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=border:#313244,label:#cdd6f4"
