#!/usr/bin/env bash
# ~/.local/bin/rofi-unicode
set -euo pipefail

list() {
python3 - <<'PY'
import sys, unicodedata
blocks = [
  (0x21,0x7E),     # ASCII
  (0xA0,0x24F),    # Latin-1 + Latin Extended (ñ, é, ü, ¿, ¡, °, ±, ×...)
  (0x370,0x3FF),   # Greek (μ, Ω, π...)
  (0x2000,0x206F), # General punctuation (—, …, •)
  (0x2070,0x209F), # Super/subscripts
  (0x20A0,0x20CF), # Currency
  (0x2100,0x214F), # Letterlike (℃, №, ™)
  (0x2190,0x21FF), # Arrows
  (0x2200,0x22FF), # Math operators (≤, ≠, ∞, √)
  (0x2300,0x23FF), # Misc technical (⌘, ⏎)
  (0x2500,0x259F), # Box drawing + blocks
  (0x25A0,0x25FF), # Geometric shapes
  (0x2600,0x27BF), # Misc symbols + dingbats (✓, ✗, ★)
  (0x1F300,0x1FAFF), # Emoji
]
for a, b in blocks:
    for cp in range(a, b + 1):
        c = chr(cp)
        name = unicodedata.name(c, None)
        if name:
            print(f"{c}  {name.title()}  (U+{cp:04X})")
PY
}

sel=$(list | rofi -dmenu -i -p "unicode" -matching normal) || exit 0
char=${sel%% *}

printf %s "$char" | wl-copy
sleep 0.1
wtype "$char"
