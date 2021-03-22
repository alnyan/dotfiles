#!/bin/sh

get_players() {
    pacmd list-sink-inputs | grep client: | cut -d' ' -f2
}

get_player_state() {
    pacmd list-sink-inputs | grep "client: $1" -B12 | grep "state: " | cut -d' ' -f2
}

get_player_name() {
    pacmd list-sink-inputs | grep "client: $1" | cut -d' ' -f3-
}

spotify_cmd() {
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$1
}

mpd_cmd() {
    mpc -h ~/.config/mpd/mpd.sock $1
}

toggle_player() {
    case "$1" in
        "<Spotify>"|"<spotify>")
            spotify_cmd PlayPause
            ;;
        "<Music Player Daemon>")
            mpd_cmd toggle
            ;;
        **)
            ;;
    esac
}

next_player() {
    case "$1" in
        "<Spotify>"|"<spotify>")
            spotify_cmd Next
            ;;
        "<Music Plaer Daemon>")
            mpd_cmd next
            ;;
        **)
            ;;
    esac
}

prev_player() {
    case "$1" in
        "<Spotify>"|"<spotify>")
            spotify_cmd Previous
            ;;
        "<Music Plaer Daemon>")
            mpd_cmd prev
            ;;
        **)
            ;;
    esac
}

toggle_active() {
    if [ -n "$1" ]; then
        name=`get_player_name $1`
        toggle_player "$name"
        echo "$name" >~/.last-active-player
    elif [ -f ~/.last-active-player ]; then
        name=`cat ~/.last-active-player`
        toggle_player "$name"
    fi
}

action="$1"
active_client=
for player in `get_players`; do
    if [ `get_player_state $player` != "CORKED" ]; then
        active_client=$player
        break
    fi
done

if [ "$action" = "toggle" ]; then
    toggle_active "$active_client"
elif [ -n "$active_client" ]; then
    name=`get_player_name $active_client`
    case "$action" in
        next)
            next_player "$name"
            ;;
        prev)
            prev_player "$name"
            ;;
        **)
            ;;
    esac
fi
