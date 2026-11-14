#!/usr/bin/env bash
# Usage: toggle_tui.sh <class_name> <command>

CLASS="$1"
shift
CMD="$@"

if hyprctl clients -j | jq -e ".[] | select(.class == \"$CLASS\")" >/dev/null 2>&1; then
    hyprctl dispatch closewindow "class:^${CLASS}$"
else
    kitty --class "$CLASS" -o font_size=10.5 -e $CMD &
fi
