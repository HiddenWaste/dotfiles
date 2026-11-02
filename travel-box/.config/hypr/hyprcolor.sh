#!/usr/bin/env bash

COLOR_FILE="$HOME/.config/hypr/myColors.lua"
ROFI_COLOR_FILE="$HOME/.config/rofi/colors.rasi"

# Ensure target directories exist
mkdir -p "$HOME/.config/rofi"

# 1. Grab 6-character hex (without leading #)
RAW_COLOR=$(hyprpicker -n -f hex)
[ -z "$RAW_COLOR" ] && exit 0

# Strip '#' if present
HEX="${RAW_COLOR#"#"}"

# Hyprland color format: rgba(RRGGBBAA)
BORDER_ACTIVE="rgba(${HEX}ee)"
BORDER_INACTIVE="rgba(${HEX}44)"

# 2. Update Hyprland live via Lua eval
hyprctl eval "hl.config({ general = { col = { active_border = '$BORDER_ACTIVE', inactive_border = '$BORDER_INACTIVE' } } })"

# 3. Persist to myColors.lua
cat <<EOF > "$COLOR_FILE"
return {
    active_border = "$BORDER_ACTIVE",
    inactive_border = "$BORDER_INACTIVE",
}
EOF

# 4. Persist to rofi colors.rasi
cat <<EOF > "$ROFI_COLOR_FILE"
* {
    border-col: #${HEX};
}
EOF

# 5. Desktop notification
if command -v notify-send >/dev/null 2>&1; then
    notify-send "Theme Updated" "Border set to #${HEX}" -i preferences-desktop-theme
fi
