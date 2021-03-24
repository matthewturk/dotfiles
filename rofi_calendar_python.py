#!/home/mturk/conda-py3/envs/py39/bin/python
import rofi_menu
import calendar
import time

class DateChange(rofi_menu.Item):
    def __init__(self, *args, **kwargs):
        self.delta_year = kwargs.pop("delta_year", 0)
        self.delta_month = kwargs.pop("delta_month", 0)
        super().__init__(*args, **kwargs)

    async def on_select(self, meta):
        meta.session['year'] += self.delta_year
        meta.session['month'] += self.delta_month
        return await super().on_select(meta)

class CurrentMonthAndYear(rofi_menu.Item):

    async def render(self, meta):
        return f"{meta.session['year']} / {meta.session['month']}"

class DayOfMonthMenu(rofi_menu.Menu):
    prompt = "Date"
    async def build(self, menu_id, meta):
        ct = time.localtime()
        meta.session.setdefault("year", ct.tm_year)
        meta.session.setdefault("month", ct.tm_mon)
        return await super().build(menu_id, meta)

    async def generate_menu_items(self, meta):
        return [CurrentMonthAndYear(),
                DateChange('Previous Year', delta_year=-1),
                DateChange('Previous Month', delta_month=-1),
                DateChange('Next Month', delta_month=1),
                DateChange('Next Year', delta_year=1) ]


if __name__ == "__main__":
    rofi_menu.run(DayOfMonthMenu(), rofi_version="1.5")  # change to 1.5 if you use older rofi version
