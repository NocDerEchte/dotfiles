#!/usr/bin/env bash
#
# zsh rc file: general shell config

# load custom aliases
[[ -f "${XDG_CONFIG_HOME}/shell/aliases" ]] && source "${XDG_CONFIG_HOME}/shell/aliases"

# run ssh-agent on startup
if [[ ! -S "${HOME}/.ssh/auth.sock" ]]; then
  eval ssh-agent
  ln -sf "$SSH_AUTH_SOCK" "${HOME}/.ssh/auth.sock"
fi
export SSH_AUTH_SOCK="${HOME}/.ssh/auth.sock"

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

# History settings. Override zap settings
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# fzf-tab options
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Load and initialise completion system
autoload -Uz compinit
compinit

# zsh hooks
# precmd() {
#   tmux refresh-client -S
# }
