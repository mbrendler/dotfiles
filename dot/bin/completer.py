#!/usr/bin/env python
# pylint: disable=missing-docstring
import sys
import os
import commands
import argparse
from itertools import groupby
from collections import OrderedDict
from curses import KEY_DOWN, KEY_UP, KEY_BACKSPACE

from menu import Menu


class CompletionListWindow(Menu):
    def __init__(self, entries, text, matcher):
        super(CompletionListWindow, self).__init__(selected=-1, list_top=1)
        self.match = matcher
        self._entries = entries
        self._input = text
        self._text = text
        self._key_actions.update({
            KEY_DOWN: self.select_next,
            ord(''): self.select_next,
            KEY_UP: self.select_previous,
            ord(''): self.select_previous,
            KEY_BACKSPACE: self.backspace,
            127: self.backspace,
        })

    def text(self):
        return self._text

    def entries(self):
        return [e for e in self._entries if self.match(e, self._input)]

    def selected_entry(self):
        try:
            return self.entries()[self._selected]
        except IndexError:
            return self._text

    def default_key_action(self, _, key_code):
        self._selected = -1
        self._top = 0
        self._input = self._text + chr(key_code)
        self._text = self._input

    def backspace(self, *_):
        self._selected = -1
        self._top = 0
        self._input = self._text[:-1]
        self._text = self._input

    def select_no_list_entry(self):
        self._selected = -1
        self._top = 0
        self._text = self._input

    def select_next(self, window, key_code):
        if self._selected == self.entries_count() - 1:
            self.select_no_list_entry()
        else:
            super(CompletionListWindow, self).select_next(window, key_code)
            self._text = self.selected_entry()

    def select_previous(self, window, key_code):
        if self._selected == 0:
            self.select_no_list_entry()
        elif self._selected == -1:
            self._selected = self.entries_count() - 1
            self._top = max(0, self.entries_count() - self.list_height(window))
            self._text = self.selected_entry()
        else:
            super(CompletionListWindow, self).select_previous(window, key_code)
            self._text = self.selected_entry()

    def _refresh(self, window):
        super(CompletionListWindow, self)._refresh(window)
        _, max_x = window.getmaxyx()
        window.addstr(0, 0, self._text[-max_x:])
        window.clrtoeol()


def unique_list(a_list):
    return OrderedDict(groupby(a_list)).keys()


def initial_text(_):
    # TODO
    # last_line = pane_content.splitlines()[-1]
    # if last_line and last_line[-1] != ' ':
    #     return last_line.split()[-1]
    return ''


def previous_pane_id():
    os.system('tmux last-pane')
    cmd = 'tmux list-panes -F "#{?pane_active,#{pane_id},}"'
    panes = commands.getoutput(cmd)
    os.system('tmux last-pane')
    return panes.strip()


def pane_pwd(pane_id):
    cmd = 'tmux list-panes -F "#{pane_id},#{pane_current_path}"'
    panes = commands.getoutput(cmd)
    for pane in panes.splitlines():
        if pane.startswith(pane_id + ','):
            return pane[len(pane_id) + 1:]
    return ''


def words(content, extra_chars='$-_', must_contain='', ignore=None):
    if ignore is None:
        ignore = set()
    result = []
    current = ''
    for c in content:
        i = ord(c)
        if 48 <= i <= 57 or 65 <= i <= 90 or 97 <= i <= 122 or c in extra_chars:
            current += c
        else:
            if current and must_contain in current and current not in ignore:
                result.append(current)
            current = ''
    return result


def expand_home_directory(paths):
    home = os.getenv('HOME')
    for path in set(paths):
        if path.startswith(home):
            paths.add(path.replace(home, '~', 1))
        elif path[0] == '~':
            paths.add(path.replace('~', home, 1))


def add_trailing_slash(paths):
    for path in set(paths):
        if path[-1] == '/':
            paths.add(path[:-1])
        else:
            paths.add(path + '/')


def files(content, ignore=None):
    ignore = ignore or set()
    ignore.add(os.getenv('HOME'))
    add_trailing_slash(ignore)
    expand_home_directory(ignore)
    return words(content, extra_chars='/~.$-_', must_contain='/', ignore=ignore)


def fuzzy_matcher(entry, string):
    for character in string:
        index = entry.find(character)
        if index >= 0:
            entry = entry[index:]
        else:
            return False
    return True


def starts_with_matcher(entry, string):
    return entry.startswith(string)


def parse_options():
    parser = argparse.ArgumentParser(description='complete words or files')
    parser.add_argument(
        'filename', metavar='FILE', type=str, help='file to completion content'
    )
    parser.add_argument(
        '--files', dest='parse_input', action='store_const',
        const=files, default=words, help='complete file paths instead of words'
    )
    parser.add_argument(
        '--fuzzy', dest='matcher', action='store_const', const=fuzzy_matcher,
        default=starts_with_matcher, help='use fuzzy matching'
    )
    return parser.parse_args()


def main():
    args = parse_options()
    pane = previous_pane_id()
    pane_content = open(args.filename).read()
    ignore = set([pane_pwd(pane)])
    parsed = args.parse_input(pane_content, ignore=ignore)
    completion_list = unique_list(reversed(parsed))
    menu = CompletionListWindow(
        completion_list, initial_text(pane_content), args.matcher
    )
    if menu.run() and menu.text():
        backspaces = ' bspace' * len(initial_text(pane_content))
        os.system('tmux send-keys -t %s%s' % (pane, backspaces))
        os.system("tmux send-keys -l -t %s '%s'" % (pane, menu.text()))
    return 0


if __name__ == '__main__':
    sys.exit(main())
