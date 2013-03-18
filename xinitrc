#! /bin/bash

# .bashrc may not be sourced yet, make sure we have a reasonable path.
. .bashrc.d/path.sh

# uncomment to enable debug log
#debug_log="/tmp/xinitrc-${USER:-unknown}.log"

if [ "$debug_log" ]
then
    touch "$debug_log"
    chmod 700 "$debug_log"
    exec >> "$debug_log" 2>&1
fi

##

load_x_resources () {
    local xresource_file="${1:-"$HOME"/.Xresources}"

    if [ -r "$xresource_file" ]
    then
        xrdb -load "$xresource_file"
    fi
}

load_cursor () {
    # /usr/include/X11/bitmaps
    xsetroot -cursor_name left_ptr
}

set_keyboard_layout () {
    setxkbmap "${1:-hu}"
}

set_wallpaper () {
    local wallpaper="${1:-"$HOME"/.wallpaper}"

    if [ -x "$( which feh )" -a -r "$wallpaper" ]
    then
        feh --no-fehbg --bg-center "$wallpaper"
    fi
}

configure_screen_saver () {
    # seconds
    local standby=${1:-0}
    local suspend=${2:-0}
    local off=${3:-600}

    xset dpms $standby $suspend $off
}

enable_user_installed_fonts () {
    if [ -d "$HOME"/.fonts -a -x "$( which font-helper )" ]
    then
        font-helper
    fi
}

##

start_session_dbus () {
    # forks to background
    # exports DBUS_SESSION_BUS_ADDRESS
    eval "$( dbus-launch --sh-syntax --exit-with-session )"
}

start_shortcut_handler () {
    # forks to background
    xbindkeys
}

start_window_event_handler () {
    if [ -x "$( which devilspie )" -a -d "$HOME"/.devilspie ]
    then
        devilspie --apply-to-existing &
    fi
}

start_screen_autolocker () {
    local autolocker=xautolock
    local locker=xlock
    local minutes_to_lock=11

    if [ -x "$( which "$autolocker" )" ]
    then
        "$autolocker" -time "$minutes_to_lock" -locker "$locker" &
    fi
}

## startup time settings

load_x_resources &
set_keyboard_layout &
set_wallpaper &
configure_screen_saver &
enable_user_installed_fonts &

# make sure it all happened, before we go ahead
wait

## start background services

start_session_dbus
start_window_event_handler
start_shortcut_handler

## start foreground programs

xterm-screen &
chromium-browser &

## start window manager
#openbox --debug 2>&1 | ts %.s >> /tmp/openbox-debug
exec openbox
