#!/bin/sh
# $SCRIPT_DIR=(PWD)  This was incorrect syntax, correct is below
SCRIPT_DIR=$(pwd)

# Base install for Gucci Smart toilet setup
#   This install ins where I am going to be testing further automation
#   that which I am most curious to start using is stow!

#   Smart Toilet will be running Ubuntu with Hyprland for now
#   as I can actually get the proper Nvidia drivers for it that way

echo "🚽 Initializing Gucci Smart Toilet Setup..."
# ^ taken from ai cause haha toilet emoji

# Good practice to update and upgrade before installing any new packages
sudo apt update && sudo apt upgrade -y

# Start with some foundational packages
sudo apt install -y vim git sudo stow curl

# Now for packages that are for aesthetics
sudo apt install fastfetch 


# Other Installations, May require modular script approach as some software
#   has multi-multi line installation methods
#   unsure currently as to what the hyperland on ubuntu script does...

# starship pokemon-colorscripts

# Let's get the hyprland out of the way!
sh <(curl -L https://raw.githubusercontent.com/JaKooLit/Ubuntu-Hyprland/24.04/auto-install.sh)
#   the first test of this will see if this successfully grabs the nvidia drivers


# Post-Installs
#   Now that the installs are done, let's populate our dotfiles!
#   to be targeted correctly we will have to run some removals so the
#   symlinks that stow creates can be made correctly
sudo rm -rf ~/.bashrc ~/.bash_aliases ~/.vimrc ~/.gitconfig ~/.config/kitty/ ~/.config/hypr/hyprland.conf

# TODO: Stow common dotfiles
# TODO: Stow smart-toilet dotfiles
