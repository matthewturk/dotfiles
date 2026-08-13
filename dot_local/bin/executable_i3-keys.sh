#!/usr/bin/env bash

CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/i3/config"

grep -E '^\s*bind(sym|code)' "$CONFIG_FILE" \
    | sed -E 's/^\s*bind(sym|code)\s+//' \
    | sed -E 's/--no-startup-id\s+//' \
    | sed -E 's/--release\s+//' \
    | sed -E "s/\\\$mod/Super/g" \
    | rofi -dmenu -i -p "i3 Shortcuts" -l 15
