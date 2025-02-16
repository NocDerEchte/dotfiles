# Dotfiles

These are my personal Dotfiles.
The purpose of this Repository is to have all my main configuration in one place and to get things on a new machine up and running as fast as possible.

## Setup

Setting up my Dotfiles is as simple as running the following commands in the terminal:
```bash
DOTFILES_DIR="$HOME/Repos/github.com/nocderechte"
mkdir -p $DOTFILES_DIR
cd $DOTFILES_DIR
git clone git@github.com:NocDerEchte/dotfiles.git
cd dotfiles
```

After that run the `setup.sh` script to set everything up:
```bash
./setup.sh
```
___
Feel free to use my Dotfiles as-is or take inspiration for your own setup.
