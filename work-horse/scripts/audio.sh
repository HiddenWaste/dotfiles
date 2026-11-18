#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed --noconfirm pipewire pipewire-pulse pipewire-alsa pipewire-audio wireplumber pavucontrol
