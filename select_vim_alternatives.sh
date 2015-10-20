#!/bin/bash

set -ex

PANES=$(tmux list-panes -F "#{pane_active},#{pane_id},#{pane_current_command}")

CURRENT_COMMAND="$(echo "$PANES" | grep '^1' | cut -d, -f3)"

if test "vim" != "$CURRENT_COMMAND" ; then
  TARGET_PANE="$(echo "$PANES" | grep ',vim$' | head -n1 | cut -d, -f2)"
  tmux select-pane -t "$TARGET_PANE"
else
  if test "pane-switch" == "$1" ; then
    # C-7
    tmux send-keys 
  fi
fi

if test "alternative" == "$1" ; then
  # C-6
  tmux send-keys ^^
fi
