#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed --noconfirm pipewire pipewire-pulse pipewire-alsa pipewire-audio wireplumber bluetui pulsemixer bluez

# Gotta actually start bluetooth
sudo systemctl enable --now bluetooth.service

# Same with the audio processes!!
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service
