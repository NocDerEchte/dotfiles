#!/usr/bin/env zsh
#
# zsh environment file: loaded when zsh is started

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

# Dotfiles repo location
export DOTFILES_DIR="$HOME/Repos/github.com/nocderechte/dotfiles"

# History settings
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

# fzf color settings
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=border:#313244,label:#cdd6f4"

# oh-my-posh theme
export POSH_THEME="${XDG_CONFIG_HOME}/oh-my-posh/catppuccin_mocha.yml"

# Add custom scripts to PATH
export PATH=$PATH:$DOTFILES_DIR/scripts
