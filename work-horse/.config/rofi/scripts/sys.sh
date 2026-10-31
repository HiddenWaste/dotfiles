#!/usr/bin/env bash

# If no argument is passed, Rofi asks the script to print the list of options
if [ -z "$1" ]; then
    echo "shutdown"
    echo "reboot"
    echo "suspend"
    echo "logout"
else
    # When you select an item, Rofi re-runs the script passing your choice as $1
    case "$1" in
        shutdown) systemctl poweroff ;;
        reboot) systemctl reboot ;;
        suspend) systemctl suspend ;;
        logout) hyprctl dispatch exit ;;
    esac
fi
