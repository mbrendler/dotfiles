#!/bin/sh

set -ex

PANES=$(tmux list-panes -F "#{pane_active},#{pane_id},#{pane_current_command}")

CURRENT_COMMAND="$(echo "$PANES" | grep '^1' | cut -d, -f3)"

if [ vim = "$CURRENT_COMMAND" ] || [ nvim = "$CURRENT_COMMAND" ] ; then
  if test "pane-switch" == "$1" ; then
    # C-7
    tmux send-keys 
  fi
else
  TARGET_PANE="$(echo "$PANES" | grep ',vim$' | head -n1 | cut -d, -f2)"
  if [ -z "$TARGET_PANE" ] ; then
    TARGET_PANE=":.+"
  fi
  tmux select-pane -t "$TARGET_PANE"
fi

if test "alternative" == "$1" ; then
  # C-6
  tmux send-keys ^^
fi
