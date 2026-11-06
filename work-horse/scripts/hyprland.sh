# This script models the necessary components for my general
#   arch setup! the main thing to note is some of this is the
#   first stuff to be installed, especially if a DE is desired.

pacman -Syu # update pacman

pacman -S hyprland hyprpaper hypridle hyprlock dunst rofi polkit-agent-kde grim slurp

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
# grim + slurp = used for screenshotting
