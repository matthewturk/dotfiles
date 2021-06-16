# py3status module for playerctl

import subprocess

def get_battery_level():
    sp = subprocess.run(
            ("headsetcontrol", "-b"),
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL)
    if sp.returncode:
        return '', ''
    headset = percent = ''
    for line in sp.stdout.decode().split("\n"):
        if line.startswith("Found"):
            headset = line[5:line.rfind('!')].strip() + ": "
        elif line.startswith('Battery: '):
            percent = line[9:].strip()
    return headset, percent

class Py3status:
    def spotbar(self):
        #format = '{headset}{percent}'
        format = '🎧 {percent}'

        headset, percent = get_battery_level()
        params = {'headset': headset, 'percent': percent}

        return {
            'full_text': self.py3.safe_format(format, params),
            'cached_until': self.py3.time_in(seconds=60)
        }

if __name__ == '__main__':
    from py3status.module_test import module_test
    module_test(Py3status)

