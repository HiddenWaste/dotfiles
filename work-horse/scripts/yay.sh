#!/usr/bin/env bash
set -euo pipefail

# Ensure git and base-devel are installed before building AUR packages
sudo pacman -S --needed --noconfirm git base-devel

# Install yay-bin if yay is not already present
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    TMP_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/yay-bin.git "$TMP_DIR/yay-bin"
    (
        cd "$TMP_DIR/yay-bin"
        makepkg -si --noconfirm
    )
    rm -rf "$TMP_DIR"
else
    echo "yay is already installed."
fi
