# pylint: disable=invalid-name,missing-docstring
from curses import (
    wrapper, KEY_ENTER, KEY_RESIZE,
    use_default_colors, color_pair, init_pair, COLOR_GREEN
)
import locale

locale.setlocale(locale.LC_ALL, '')


class Menu(object):
    def __init__(self, selected=0, scroll_offset=0, list_top=0, list_bottom=0):
        self._scroll_offset = scroll_offset
        self._list_top = list_top
        self._list_bottom = list_bottom
        self._selected = selected
        self._top = 0
        self._key_actions = {
            27: self.meta_key,
            10: lambda *_: True,
            KEY_ENTER: lambda *_: True,
            KEY_RESIZE: lambda *_: None,
        }
        self._meta_key_actions = {
            27: lambda *_: False
        }

    def meta_key(self, window, _):
        key_code = window.getch()
        action = self._meta_key_actions.get(key_code, lambda *_: None)
        return action(window, key_code)

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
        return height - self._list_top - self._list_bottom

    def select_next(self, window, key_code):
        self._selected = min(self._selected + 1, self.entries_count() - 1)
        old_pos = self._top + self.list_height(window) - self._scroll_offset
        if self._selected <= 0:
            self.select_first(window, key_code)
        elif self._selected >= old_pos:
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
        list_height = height - self._list_top - self._list_bottom
        entries_to_display = self.entries()[self._top:self._top + list_height]
        for i, entry in enumerate(entries_to_display, start=self._list_top):
            text = self.displayed_text_by_entry(entry)[:width - 2]
            window.addstr(i, 0, text)
            window.clrtobot()
            is_selected = self._selected == self._top + i - self._list_top
            window.chgat(i, 0, color_pair(2) if is_selected else color_pair(1))
        if not entries_to_display:
            window.clear()

    def _loop(self, window):
        try:
            use_default_colors()
            init_pair(1, -1, -1)
            init_pair(2, -1, COLOR_GREEN)
            while 1:
                self._refresh(window)
                key = window.getch()
                action = self._key_actions.get(key, self.default_key_action)
                result = action(window, key)
                if result is not None:
                    return result
        except KeyboardInterrupt:
            pass
