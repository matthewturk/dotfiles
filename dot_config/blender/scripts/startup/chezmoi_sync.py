import bpy
import json
import os
import shutil
import subprocess
import threading
import sys
from bpy.app.handlers import persistent

# Global tracking state for the background thread
UV_STATUS = "CHECKING"

def draw_popup(self, context):
    global UV_STATUS
    layout = self.layout
    if UV_STATUS == "NEEDS_SYNC":
        layout.label(text="Blender environment is out of sync with uv.lock!", icon='ERROR')
        layout.label(text="Running 'uv sync' automatically in the background...", icon='INFO')
    elif UV_STATUS == "SYNC_COMPLETE":
        layout.label(text="Environment Sync Completed Successfully!", icon='CHECKMARK')
    elif UV_STATUS == "ERROR":
        layout.label(text="Background uv sync failed. Check system console.", icon='CANCEL')

def run_background_sync(uv_bin, project_dir):
    global UV_STATUS
    try:
        # Executes 'uv sync' natively using the workspace files in project_dir
        subprocess.run([uv_bin, "sync"], cwd=project_dir, check=True)
        UV_STATUS = "SYNC_COMPLETE"
        print("[Chezmoi/uv] Background sync completed successfully.")
        
        # Force a safe UI redraw in Blender to update notifications if open
        bpy.ops.wm.redraw_timer(type='DRAW_WIN_SWAP', iterations=1)
    except Exception as e:
        UV_STATUS = "ERROR"
        print(f"[Chezmoi/uv Error] Background uv sync failed: {e}")

@persistent
def load_and_sync_chezmoi(dummy=None):
    global UV_STATUS
    
    # Define paths relative to your local blender config directory
    project_dir = os.path.expanduser("~/.config/blender/")
    config_path = os.path.join(project_dir, "config.json")
    
    # -------------------------------------------------------------------------
    # PART 1: Apply Plain-Text Preferences (UI Scale, Render Devices)
    # -------------------------------------------------------------------------
    if os.path.exists(config_path):
        try:
            with open(config_path, "r") as f:
                config = json.load(f)
            
            prefs = bpy.context.preferences
            
            # 1. Set Interface Scale
            if "interface_scale" in config:
                prefs.view.ui_scale = config["interface_scale"]

            # 2. Configure Compute/Render Devices (Cycles)
            if "render_device_type" in config and 'cycles' in prefs.addons:
                cprefs = prefs.addons['cycles'].preferences
                device_type = config["render_device_type"]
                
                if device_type != "NONE":
                    cprefs.compute_device_type = device_type
                    cprefs.get_devices()
                    for device in cprefs.devices:
                        device.use = True
                else:
                    cprefs.compute_device_type = 'NONE'
                    
            print("[Chezmoi/Preferences] Applied hardware configurations successfully.")
        except Exception as e:
            print(f"[Chezmoi/Preferences Error] Failed to parse config.json: {e}")
    else:
        print(f"[Chezmoi/Preferences] No config.json found at {config_path}")

    # -------------------------------------------------------------------------
    # PART 2: Resolve Path & Verify Python Environment Sync via uv
    # -------------------------------------------------------------------------
    # Dynamically find uv executable in system PATH
    uv_bin = shutil.which("uv")
    
    # GUI Application Fallback (if Steam clears your shell variables)
    if not uv_bin:
        fallback = os.path.expanduser("~/.local/bin/uv")
        if os.path.exists(fallback):
            uv_bin = fallback

    if not uv_bin:
        print("[Chezmoi/uv Error] Could not find 'uv' in system PATH or common local fallback.")
        return

    # Dynamically attach venv path matching active Python major.minor version
    py_version = f"{sys.version_info.major}.{sys.version_info.minor}"
    uv_venv = os.path.join(project_dir, ".venv", "lib", f"python{py_version}", "site-packages")
    
    if os.path.exists(uv_venv) and uv_venv not in sys.path:
        sys.path.append(uv_venv)
        print(f"[Chezmoi/uv] Dynamically attached venv environment for Python {py_version}")

    try:
        # Check if python environment matches lockfile expectations
        check = subprocess.run(
            [uv_bin, "pip", "check"], 
            cwd=project_dir, 
            capture_output=True
        )
        
        if check.returncode != 0:
            UV_STATUS = "NEEDS_SYNC"
            
            # Display a quick non-blocking native alert popup box 
            bpy.context.window_manager.popup_menu(draw_popup, title="Environment Sync", icon='URL')
            
            # Spin up background process so the viewport doesn't freeze during lock matching
            threading.Thread(target=run_background_sync, args=(uv_bin, project_dir), daemon=True).start()
        else:
            UV_STATUS = "OK"
            print("[Chezmoi/uv] Local packages match lockfile definitions perfectly.")
            
    except Exception as e:
        print(f"[Chezmoi/uv Error] Failed during dependency environment verification: {e}")

def register():
    # Hook directly into the post-load routine so context variables exist safely
    bpy.app.handlers.load_post.append(load_and_sync_chezmoi)

def unregister():
    if load_and_sync_chezmoi in bpy.app.handlers.load_post:
        bpy.app.handlers.load_post.remove(load_and_sync_chezmoi)

if __name__ == "__main__":
    # We only register the handler hook. 
    # Because it lives in a nested directory, Blender automatically discovers and runs it on boot.
    register()
