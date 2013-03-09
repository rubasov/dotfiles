#! /bin/bash

# TODO list dependencies
#     ~/bin/decomment
#     ~/bin/menu
#     ~/bin/togglexkbmap
#     ~/bin/xlockscreen
#     devilspie
#     feh
#     openbox
#     osd_cat
#     trayer
#     wmctrl
#     xautolock
#     xbindkeys
#     xlock
#     ?amixer
#     ...terminus...

# uncomment to debug
#
#debug_log="/tmp/xinitrc-${USER:-unknown}.log"
if [ "$debug_log" ]
then
    touch "$debug_log"
    chmod 700 "$debug_log"
    exec >> "$debug_log" 2>&1
fi

# .bashrc may not be sourced yet, so make sure we have a reasonable path
. .bashrc.d/path.sh

conf_dir="$HOME/.Xrc.d"

# the bug below should be fixed in dbus-x11 1.6.2-1
# to understand the stdin redirection see:
#     /etc/X11/Xsession.d/75dbus_dbus-launch
#     http://bugs.debian.org/453755
#     https://bugs.freedesktop.org/show_bug.cgi?id=39197
#eval "$( dbus-launch --sh-syntax --exit-with-session < /dev/null )"

# start session dbus (will export DBUS_SESSION_BUS_ADDRESS)
eval "$( dbus-launch --sh-syntax --exit-with-session )"

# keyboard layout
decomment < "$conf_dir/xkbmap" |
    xargs --no-run-if-empty setxkbmap

# autorepeat
#xset r on

# select cursor from
# /usr/include/X11/bitmaps/
#xsetroot -cursor_name left_ptr

test -r "$HOME/.Xresources" &&
    xrdb -load "$HOME/.Xresources"

test -d ~/.fonts -a -x ~/bin/font-helper
    ~/bin/font-helper

# background picture
# --bg-tile | --bg-center
test -x "$( which feh )" -a -r "$conf_dir/background" &&
    feh --bg-center "$conf_dir/background"

#test -x "$( which conky )" -a -r ~/.conkyrc &&
#    conky

# screen saver
decomment < "$conf_dir/xset-dpms" |
    xargs --no-run-if-empty xset dpms

# system tray
#test -x "$( which trayer )" &&
#    decomment < "$conf_dir/trayer" |
#        xargs --no-run-if-empty trayer &

# window autoformatting
test -x "$( which devilspie )" -a -d ~/.devilspie &&
    devilspie --apply-to-existing &

## autolock screen
#decomment < "$conf_dir/xautolock" |
#    xargs xautolock &

# shortcut key bindings
xbindkeys

# autostarted foreground programs
#decomment < "$conf_dir/xterm" |
#    xargs xterm &
$HOME/bin/menu-screen &
chromium-browser &
#sonata &

# window manager
exec openbox
