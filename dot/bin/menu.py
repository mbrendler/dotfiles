from curses import wrapper, A_REVERSE, A_NORMAL, KEY_ENTER
import locale

locale.setlocale(locale.LC_ALL, '')

class Menu(object):  # pylint: disable=abstract-class-not-used
    def __init__(self, selected=0, scroll_offset=0, list_top=0):
        self._scroll_offset = scroll_offset
        self._list_top = list_top
        self._selected = selected
        self._top = 0
        self._key_actions = {
            27: lambda *_: False,
            10: lambda *_: True,
            KEY_ENTER: lambda *_: True,
        }

    def entries(self):
        raise NotImplementedError

    def entries_count(self):
        return len(self.entries())

    def displayed_text_by_entry(self, entry):  # pylint: disable=no-self-use
        return entry

    def selected(self):
        return self._selected

    def default_key_action(self, window, key_code):
        pass

    def list_height(self, window):
        height, _ = window.getmaxyx()
        return height - self._list_top

    def select_next(self, window, key_code):
        self._selected = min(self._selected + 1, self.entries_count() - 1)
        if self._selected == 0:
            self.select_first(window, key_code)
        elif self._selected >= self._top + self.list_height(window) - self._scroll_offset:
            last_top = self.entries_count() - self.list_height(window)
            self._top = min(last_top, self._top + 1)

    def select_previous(self, window, key_code):
        self._selected = max(self._selected - 1, 0)
        if self._selected == self.entries_count() - 1:
            self.select_last(window, key_code)
        elif self._selected < self._top + self._scroll_offset:
            self._top = max(0, self._top - 1)

    def select_first(self, *_):
        self._selected = 0
        self._top = 0

    def select_last(self, window, *_):
        self._selected = self.entries_count() - 1
        self._top = max(0, self.entries_count() - self.list_height(window))

    def run(self):
        return wrapper(self._loop)

    def _refresh(self, window):
        window.refresh()
        height, width = window.getmaxyx()
        list_height = height - self._list_top
        entries_to_display = self.entries()[self._top:self._top + list_height]
        for i, entry in enumerate(entries_to_display, start=self._list_top):
            window.addstr(i, 0, self.displayed_text_by_entry(entry)[:width - 2])
            window.clrtobot()
            is_selected = self._selected == self._top + i - self._list_top
            window.chgat(i, 0, A_REVERSE if is_selected else A_NORMAL)

    def _loop(self, window):
        while 1:
            self._refresh(window)
            key_code = window.getch()
            action = self._key_actions.get(key_code, self.default_key_action)
            result = action(window, key_code)
            if result is not None:
                return result
