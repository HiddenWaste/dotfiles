#!/bin/bash

# Path to your wallpaper image
WALLPAPER="/home/carter/Pictures/wallhaven-lywpjl.jpg"

# 1. Resize image down to pull the main dominant color
# 2. Extract the Hex code
# 3. Strip any weird characters so it's a pure hex code (e.g., ff00aa)
COLOR=$(convert "$WALLPAPER" -resize 1x1 txt:- | grep -E -o "#[0-9A-Fa-f]{6}" | head -n 1)

# Hyprland expects a hex code without the '#' symbol for its border configuration
HEX_CLEAN=$(echo "$COLOR" | tr -d '#')

# Apply it to Hyprland's active border instantly (adds full opacity 'ff' to the front)
hyprctl keyword general:col.active_border "rgba(${HEX_CLEAN}ff)"
