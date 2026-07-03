import bpy
import json
import os
from bpy.app.handlers import persistent

# Mark the handler as persistent so it doesn't get wiped if a new file is opened
@persistent
def configure_blender(dummy=None):
    config_path = os.path.expanduser("~/.config/blender/config.json")
    if not os.path.exists(config_path):
        print(f"[Chezmoi Setup] Config file not found at {config_path}")
        return

    try:
        with open(config_path, "r") as f:
            config = json.load(f)
    except Exception as e:
        print(f"[Chezmoi Setup] Failed to parse config.json: {e}")
        return

    prefs = bpy.context.preferences
    
    # 1. Set Interface Scale
    if "interface_scale" in config:
        prefs.view.ui_scale = config["interface_scale"]

    # 2. Configure Compute/Render Devices (Cycles)
    if "render_device_type" in config:
        # Ensure the cycles addon is enabled before tweaking it
        if 'cycles' in prefs.addons:
            cprefs = prefs.addons['cycles'].preferences
            device_type = config["render_device_type"]
            
            if device_type != "NONE":
                cprefs.compute_device_type = device_type
                cprefs.get_devices()
                for device in cprefs.devices:
                    device.use = True
            else:
                cprefs.compute_device_type = 'NONE'
                
    print("[Chezmoi Setup] Device and preference configurations applied successfully.")

def register():
    # load_post handlers run after a blend file is loaded (including the startup file)
    bpy.app.handlers.load_post.append(configure_blender)

def unregister():
    if configure_blender in bpy.app.handlers.load_post:
        bpy.app.handlers.load_post.remove(configure_blender)

# Blender executes startup scripts in a global context where register() isn't automatically called
if __name__ == "__main__":
    register()
    # Force a run on initial startup loop
    configure_blender()
