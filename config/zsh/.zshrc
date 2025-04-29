#!/usr/bin/env zsh
#
# zsh rc file: general shell config

# === General settings ===

# Dotfiles repo location
export DOTFILES_DIR="${HOME}/Repos/github.com/nocderechte/dotfiles"

# Add custom scripts to PATH
export PATH=$PATH:$DOTFILES_DIR/scripts

# Source custom aliases
source "${XDG_CONFIG_HOME}/zsh/aliases"

# History settings
export HISTFILE="${ZDOTDIR:-${HOME}/.config/zsh}/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# === Shell looks ===

# Load oh-my-posh theme
export POSH_THEME="${XDG_CONFIG_HOME}/oh-my-posh/catppuccin_mocha.yml"

# Load zap zsh plugins
source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug 'zap-zsh/supercharge'
plug 'embeddedpenguin/sanekeybinds'
plug 'zap-zsh/fzf'
plug 'Aloxaf/fzf-tab'
plug 'zsh-users/zsh-autosuggestions'
plug 'wintermi/zsh-oh-my-posh' # load last, otherwise transient prompt will fail

# fzf color settings
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=border:#313244,label:#cdd6f4"

# fzf-tab options
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Load and initialise completion system
autoload -Uz compinit
compinit

# === zsh hooks ===
precmd() {
  tmux refresh-client -S
}
