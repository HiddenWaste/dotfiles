# This script models the necessary components for my general
#   arch setup! the main thing to note is some of this is the
#   first stuff to be installed, especially if a DE is desired.
#
#!/usr/bin/env bash
set -euo pipefail

sudo pacman -Syu --noconfirm # update pacman

sudo pacman -S --needed --noconfirm hyprland hyprpaper hypridle hyprlock dunst rofi polkit-kde-agent grim slurp wl-clipboard jq otf-hermit-nerd 

# hyprland - wayland based tiling window manager
#               (wayland is the compositor)
# hyprpaper - wallpaper daemon
# hypridle - provides screen timeout capabilities
# hyprlock - lock screen by command or hypridle trigger
# 
# dunst - notification daemon, monitor scripts in scripts/
#
# rofi - application launcher but more! Plenty of customization and scripting capabilities
#   super + space = applications
#   super + esc = shut down, restart, etc
#   super + tab = window switching
#   super + ??? = config shortcuts
#
# polkit-agent-kde -
#
# grim + slurp - used for screenshotting
#
# wl-clipboard - provides a clipboard along with commands like wl-copy and wl-paste to interact with the clipboard via cli
#
# jq - required for rofi to see dunst log history for relevant script(s)
#
# otf-hermit-nerd - nerd font! Needed for emoticons and such.  
