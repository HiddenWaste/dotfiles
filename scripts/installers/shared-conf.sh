#!/usr/bin/env bash
set -euo pipefail

# Zellij: configuration and layouts!  
ln -sfn ~/code/dotfiles/common/.config/zellij/ ~/.config/

# Fastfetch
rm -rf ~/.config/fastfetch/*
mkdir -p ~/.config/fastfetch

ln -sfn ~/code/dotfiles/common/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
ln -sfn ~/code/dotfiles/common/.config/fastfetch/winter.txt ~/.config/fastfetch/poke.txt

# Hyprland
#   While each system will have unique customizations, underlying keybinds and functionalities are needed to be shared
ln -sfn ~/code/dotfiles/common/.config/hypr/ ~/.config/

# Rofi
ln -sfn ~/code/dotfiles/common/.config/rofi/ ~/.config/

# Bash
ln -sf ~/code/dotfiles/common/.bashrc ~/.bashrc
ln -sf ~/code/dotfiles/common/.bash_functions ~/.bash_functions
ln -sf ~/code/dotfiles/common/.bash_aliases ~/.bash_aliases
ln -sf ~/code/dotfiles/common/.bash_profile ~/.bash_profile
ln -sf ~/code/dotfiles/common/.bash_logout ~/.bash_logout


# Vim
ln -sf ~/code/dotfiles/common/.vimrc ~/.vimrc

# Git
ln -sf ~/code/dotfiles/common/.gitconfig ~/.gitconfig
