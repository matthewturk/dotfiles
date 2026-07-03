from . import chezmoi_sync

# Define the Blender addon/script metadata block
bl_info = {
    "name": "Chezmoi Environment Sync",
    "author": "Matthew Turk",
    "version": (1, 0),
    "blender": (5, 0, 0),
    "location": "Startup",
    "description": "Automated text configuration and uv environment syncing via Chezmoi.",
    "category": "System",
}

def register():
    # Pass registration downstream to your sync logic
    chezmoi_sync.register()

def unregister():
    # Allow safe unregistering if needed
    chezmoi_sync.unregister()

if __name__ == "__main__":
    register()
