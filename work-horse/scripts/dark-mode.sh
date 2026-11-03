#!/usr/bin/env bash

# Install required packages (with standard spaces and --needed)
sudo pacman -S --needed xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
  dconf adw-gtk-theme qt5ct qt6ct kvantum

# Ensure target config directories exist
mkdir -p ~/.config/xdg-desktop-portal
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0

# Configure XDG Desktop Portal for Hyprland
cat << 'EOF' > ~/.config/xdg-desktop-portal/hyprland-portals.conf
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.Settings=gtk
EOF

# GTK 3 Applications
cat << 'EOF' > ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name = adw-gtk3-dark
gtk-application-prefer-dark-theme = 1
EOF

# GTK 4 Applications
cat << 'EOF' > ~/.config/gtk-4.0/settings.ini
[Settings]
gtk-theme-name = adw-gtk3-dark
gtk-application-prefer-dark-theme = 1
EOF

# Apply dconf/gsettings immediately for the current session
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

# Restart portals so running browsers pick up the change immediately
systemctl --user restart xdg-desktop-portal-gtk.service xdg-desktop-portal.service
