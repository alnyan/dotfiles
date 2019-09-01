#!/bin/env bash

feh --bg-scale ~/.config/wallpaper
pulseaudio

if [[ -f ~/.config/i3/i3rc-user.sh ]]; then
    source ~/.config/i3/i3rc-user.sh
fi
