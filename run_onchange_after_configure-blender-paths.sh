#!/bin/bash

echo "Hello!"
BLENDER_DIR="$HOME/.config/blender"
GENERIC_STARTUP="$BLENDER_DIR/scripts/startup"

# Ensure our generic directory paths exist
mkdir -p "$GENERIC_STARTUP"

# Loop through any version-specific folders Steam/Blender has initialized (e.g., 4.2, 4.3)
for version_dir in "$BLENDER_DIR"/[0-9].*; do
    if [ -d "$version_dir" ]; then
        # Create the local internal scripts path inside the version folder
        mkdir -p "$version_dir/scripts"
        
        # Symlink the version-agnostic 'startup' folder into the version directory
        if [ ! -L "$version_dir/scripts/startup" ]; then
            rm -rf "$version_dir/scripts/startup" # Clean up existing default folder
            ln -s "$GENERIC_STARTUP" "$version_dir/scripts/startup"
            echo "🔗 Linked generic startup scripts into Blender version: $(basename "$version_dir")"
        fi
    fi
done
