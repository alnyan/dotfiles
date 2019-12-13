#!/bin/env bash

feh --bg-scale ~/.config/wallpaper

if [[ -f ~/.config/i3/i3rc-user.sh ]]; then
    source ~/.config/i3/i3rc-user.sh
fi
