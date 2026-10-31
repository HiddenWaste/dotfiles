#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.config/rofi/scripts"

# 1. When Rofi opens (no selection yet), gather options from all .sh scripts
if [ -z "$1" ]; then
    for script in "$SCRIPT_DIR"/*.sh; do
        [ -x "$script" ] || continue
        prefix=$(basename "$script" .sh)
        # Call each script with no args and prefix its output with its filename
        "$script" | sed "s/^/${prefix} /"
    done
else
    # 2. When you select an item (e.g., "sys shutdown"), split the prefix and argument
    prefix="${1%% *}"
    arg="${1#* }"
    nohup "$SCRIPT_DIR/${prefix}.sh" "$arg" >/dev/null 2>&1 &
fi

