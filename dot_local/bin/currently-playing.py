import obspython as obs
import subprocess

interval    = 5
source_name = "currentlyplaying"

# ------------------------------------------------------------

def run(*cmdlist):
    return subprocess.run(
            cmdlist,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL).stdout.decode()

def player_args(players = None):
    if not players:
        return 'playerctl',
    else:
        return 'playerctl', '-p', players

def get_status(players = None):
    status = run(*player_args(players), 'status')[:-1]
    if status in ('Playing', 'Paused'):
        return status
    return ''

def get_info(players = None, fmt = "{{artist}} / {{title}}"):
    args = 'metadata', '--format', f'{fmt}'
    return run(*player_args(players), *args).strip()


def update_text():
    global interval
    global source_name

    source = obs.obs_get_source_by_name(source_name)
    if source is None:
        return
    try:
        status = get_status()

        if status == 'Playing':
            text = get_info()
            if text == '/ -': text = ""
        else:
            text = ""
    except Exception as err:
        obs.script_log(obs.LOG_WARNING, "Error !" + str(err))
        obs.remove_current_callback()
        return
    settings = obs.obs_data_create()
    obs.obs_data_set_string(settings, "text", text)
    obs.obs_source_update(source, settings)
    obs.obs_data_release(settings)

    obs.obs_source_release(source)

def refresh_pressed(props, prop):
    update_text()

# ------------------------------------------------------------

def script_description():
    return "Updates a text source to the results of playerctl\n\nOriginally by Jim, modified by Matt"

def script_update(settings):
    global interval
    global source_name

    interval    = obs.obs_data_get_int(settings, "interval")
    source_name = obs.obs_data_get_string(settings, "source")

    obs.timer_remove(update_text)

    if source_name != "":
        obs.timer_add(update_text, interval * 1000)

def script_defaults(settings):
    obs.obs_data_set_default_int(settings, "interval", 30)

def script_properties():
    props = obs.obs_properties_create()

    obs.obs_properties_add_int(props, "interval", "Update Interval (seconds)", 5, 3600, 1)

    p = obs.obs_properties_add_list(props, "source", "Text Source", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
    sources = obs.obs_enum_sources()
    if sources is not None:
        for source in sources:
            source_id = obs.obs_source_get_unversioned_id(source)
            if source_id == "text_gdiplus" or source_id == "text_ft2_source":
                name = obs.obs_source_get_name(source)
                obs.obs_property_list_add_string(p, name, name)

        obs.source_list_release(sources)

    obs.obs_properties_add_button(props, "button", "Refresh", refresh_pressed)
    return props
