#!/usr/bin/bash


if [ $UID -eq 0 ]; then
  printf "Do not run this script as sudo or with the root user!\nThe script will ask for permission if needed.\n"
  exit 1
fi

readonly DOTFILES_DIR="$HOME/Repos/github.com/nocderechte/dotfiles"

create_symlinks() {

  readonly USER_CONF_DIR="$HOME/.config"
  readonly USER_FONT_DIR="$HOME/.local/share/fonts/"

  # create config directories if missing
  mkdir -p "$USER_CONF_DIR/alacritty"
  mkdir -p "$USER_CONF_DIR/tmux"

  # create symlinks for config files
  ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
  ln -sf "$DOTFILES_DIR/alacritty/alacritty.toml" "$USER_CONF_DIR/alacritty/alacritty.toml"
  ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$USER_CONF_DIR/tmux/tmux.conf"

  # create symlinks for font files
  find "$DOTFILES_DIR/fonts/" -name "*.ttf" -exec ln -sf {} "$USER_FONT_DIR" \;
  fc-cache

}

install_packages() {
  local base_pkgs=(
    git
    curl
    zsh
    tmux
    bat
    fzf
    zoxide
  )

  local extra_pkgs=(
    code
    spotify-client
    steam
    chrome
  )


  printf "\\b--- Base packages ---\n"
  printf "\\b - %s\n" "${base_pkgs[@]}"
  read -r -p 'Install all packages in this list? [Y/n]' input

  if [[ $input == "n" || $input == "N" ]]; then
    printf "Skipping\n\n"
  else
    sudo apt-get install -y "${base_pkgs[@]}"
    printf '\n\n'
  fi


  printf "\\b--- Extra packages ---\n"
  printf "\\b - %s\n" "${extra_pkgs[@]}"
  read -r -p 'Install all packages in this list? [Y/n]' input

  if [[ $input == "n" || $input == "N" ]]; then
    printf "Skipping\n\n"
  else
    sudo apt-get install -y "${base_pkgs[@]}"
    printf '\n\n'
  fi
}

setup_omz() {

  if [ ! -d "$HOME/.oh-my-zsh/" ]; then
    printf 'Installing oh-my-zsh.\n'

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    printf 'Oh-my-zsh already installed.\n'
  fi

  declare -A omz_plugins=(
    ["fzf_tab"]="https://github.com/Aloxaf/fzf-tab"
    ["zsh_syntax_highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    ["fast_syntax_highlighting"]="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
    ["zsh_autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
  )

  for plugin in "${!omz_plugins[@]}"; do
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/$plugin" ]; then
      printf "cloning %s plugin\n" "$plugin"
      git clone "${omz_plugins[$plugin]}" "$HOME/.oh-my-zsh/custom/plugins/$plugin"
    fi
  done

  printf 'all plugins available.\n'

}


printf 'Starting package installation.\n'
install_packages

printf 'Starting oh-my-zsh setup.\n'
setup_omz

printf 'Creating symlinks for config files.\n'
create_symlinks
