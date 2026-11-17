#!/usr/bin/env bash
set -euo pipefail

# CONSTANTS
REPO_URL="https://github.com/HiddenWaste/dotfiles"
DOTFILES_DIR="$HOME/code/dotfiles"

MODULES=(
    "hyprland.sh"
    "yay.sh"
    "dark-mode.sh"
    "term-tools.sh"
    "networking.sh"
    "secrets.sh"
    "audio.sh"
    "docker.sh"
    "general-apps.sh"
    "work-packages.sh"
    "work-repos.sh"
)

# Order of installations
#  ===== SETUP =====
#
# 1 - hyprland.sh
#   first things first: we need our foundational packages and tools for our makeshift desktop environment.
# 2 - yay.sh
#   yay is needed for all the following automated scripts. its the package used to handle AUR installations!
#
#   ===== INSTALLATION =====
#
# 3 - term-tools.sh
# 4 - networking.sh
# 5 - secrets.sh
# 6 - audio.sh
# 7 - docker.sh
# 8 - general-apps.sh
# 9 - work-packages.sh
# 10 - work-repos.sh
#
#   ===== CONFIGURATION =====
#
# 11 - dark-mode.sh
#   force dark mode across as many applications as possible
# 12 - shared-conf.sh
#   common config files from dotfiles repo!
#
#   ===== END =====

# install git, create dotfiles dir
sudo pacman -Syu --needed --noconfirm git
mkdir -p "$(dirname "$DOTFILES_DIR")"

if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$REPO_URL" "$DOTFILES_DIR"
else
    git -C "$DOTFILES_DIR" pull
fi

cd "$DOTFILES_DIR/work-horse/scripts/"

# Execute each module in order
SCRIPTS_DIR="$DOTFILES_DIR/work-horse/scripts"
for mod in "${MODULES[@]}"; do
    echo "========================================"
    echo "==> Running $mod..."
    echo "========================================"
    bash "$SCRIPTS_DIR/$mod"
done
