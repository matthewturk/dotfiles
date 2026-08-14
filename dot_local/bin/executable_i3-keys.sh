#!/usr/bin/env bash

CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/i3/config"

# 1. Parse the config: Squeeze spaces, strip keywords/flags, and swap $mod for Super
list=$(grep -E '^\s*bind(sym|code)' "$CONFIG_FILE" \
    | tr -s ' ' \
    | sed -E 's/^\s*bind(sym|code)\s+//' \
    | sed -E 's/--release\s+//' \
    | sed -E 's/--no-startup-id\s+//' \
    | sed -E 's/\$mod/Super/g')

# 2. Pipe to rofi and store the user's choice in a variable
selection=$(echo "$list" | rofi -dmenu -i -p "Run Shortcut" -l 15)

# 3. If the user picked something (didn't press Escape), execute it
if [ -n "$selection" ]; then
    # Extract everything *after* the first space (which isolates the command)
    command=$(echo "$selection" | cut -d' ' -f2-)
    
    # Pass the command to i3 to execute
    i3-msg "$command"
fi
