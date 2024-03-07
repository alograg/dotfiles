#!/usr/bin/env bash

source "${HOME}/.local/scripts/status"

find ~/.local/share/applications/ -type f -perm /u=x -exec basename {} \; >> ~/.cache/dmenu_run
sort -ubf ~/.cache/dmenu_run|tee ~/.cache/dmenu_run

xrandr --output HDMI-1 --auto --left-of eDP-1 || echo 'i cant change the monitor position' >> ~./.xsession-error

