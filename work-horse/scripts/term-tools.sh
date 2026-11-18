#!/usr/bin/env bash
set -euo pipefail

yay -S --needed --noconfirm kitty fastfetch pokemon-colorscripts starship zellij-bin

# NOTE: Vim is installed at initial chroot level
#
# kitty - Preferred terminal emulator
#
# fastfetch - Tool to show sys info and some sort of 'logo' in new terminal sessions!
#
# pokemon-colorscripts - utilized with fastfetch to show pokemon as the logo in a new terminal session
#
# starship - prompt prettyification! used across devices to be able to easily tell what terminal sessions are on what machines
#
# zellij - preffered terminal multiplexer, the non -bin version takes forever to install and tends to fail
