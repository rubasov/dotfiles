## ~/.bash_profile

# Ideally terminal multiplexers like screen or tmux could be set as your unix
# login shell, directly started by whatever login mechanism you have.
# Unfortunately many times it is impossible to change your login shell (e.g. in
# restrictive work environments) so here we do the following:
#
#   * start the desired terminal multiplexer via bash first
#   * but make sure we don't overdo it, i.e.
#     no infinite recursion of bash-multiplexer-bash-...
#
# Practically speaking you should configure your preferred multiplexer that it
# never starts _login_ shells.
#
# Here we prefer starting the multiplexers that:
#
#   * they try to attach to an existing session
#   * if there's no session to attach to, then create a new session
#   * in case we could attach, detach all other clients

if
    shopt -q login_shell && # login shell
    [[ $- =~ i ]]        && # interactive shell
    test "$TERM"         && # terminal type is set
    tty --silent            # attached terminal
then

    echo >&2 "Select initial program to run!"

    select start in "bash" "screen" "tmux" "x"
    do
        break
    done

    case "$start" in

        bash)
            # do nothing since we already run bash
            ;;

        screen)
            exec screen -OU -xdR
            ;;

        tmux)
            # http://unix.stackexchange.com/questions/1045
            export TERM=xterm-256color
            tmux -d attach-session 2>/dev/null ||
                exec tmux new-session
            ;;

        x)
            # If you have authorization problems see:
            #   * /etc/X11/Xwrapper.config
            #   * dpkg-reconfigure x11-common
            xinit &
            logout
            ;;

        *)
            echo >&2 "${BASH_SOURCE[0]}: no such menu item: $REPLY"
            echo >&2 "${BASH_SOURCE[0]}: starting bash instead"
            # do nothing since we already run bash
            ;;

    esac

fi

test -r "$HOME"/.bashrc
    . "$HOME"/.bashrc
