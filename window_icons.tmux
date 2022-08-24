#!/usr/bin/env bash

set -e

placeholder="\#{tmux_window_icon_indicators}"

active_icon_config='@window_icon_active'

tmux_option() {
    local -r value=$(tmux show-option -gqv "$1")
    local -r default="$2"

    if [ -n "$value" ]; then
        echo "$value"
    else
        echo "$default"
    fi
}

default_active_icon=' xxx '

main() {
  local -r \
    active_icon=$(tmux_option "$active_icon_config" "$default_active_icon")

  local -r \
    icon_list="#{?current_window_flag,,$active_icon }"

  local -r window_current="$(tmux_option "window-status-current-format")"
  tmux set-window-option -gq "window-status-current-format" "ok"

}

main
