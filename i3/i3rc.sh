#!/bin/env bash

if [[ -f ~/.config/wallpaper ]]; then
    feh --bg-center ~/.config/wallpaper
fi

if [[ -f ~/.config/i3/i3rc-user.sh ]]; then
    source ~/.config/i3/i3rc-user.sh
fi
