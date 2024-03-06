#!/usr/bin/env bash

source "${HOME}/.local/scripts/status"

find ~/.local/share/applications/ -type f -perm /u=x -exec basename {} \; >> ~/.cache/dmenu_run

