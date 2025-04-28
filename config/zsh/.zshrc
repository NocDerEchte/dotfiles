# === zsh rc === #

# Source custom aliases
source "${XDG_CONFIG_HOME}/zsh/aliases"

# Load zap zsh plugins
source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug 'zap-zsh/supercharge'
plug 'wintermi/zsh-oh-my-posh'
plug 'embeddedpenguin/sanekeybinds'
plug 'zap-zsh/fzf'
plug 'Aloxaf/fzf-tab'
plug 'zsh-users/zsh-autosuggestions'

# Load and initialise completion system
autoload -Uz compinit
compinit

# History Settings
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# zsh hooks
precmd() {
  tmux refresh-client -S
}
