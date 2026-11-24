#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.config/rofi/scripts"

# 1. When Rofi opens (no selection yet), gather options from all .sh scripts
if [ -z "$1" ]; then
    for script in "$SCRIPT_DIR"/*.sh; do
        [ -x "$script" ] || continue
        prefix=$(basename "$script" .sh)
        # Show each option bare; stash the script name in rofi's hidden info field
        "$script" | while IFS= read -r line; do
            printf '%s\0info\x1f%s\n' "$line" "$prefix"
        done
    done
else
    # 2. On selection, $1 is the bare option and $ROFI_INFO is the script name
    [ -n "$ROFI_INFO" ] || exit 0
    nohup "$SCRIPT_DIR/${ROFI_INFO}.sh" "$1" >/dev/null 2>&1 &
fi

