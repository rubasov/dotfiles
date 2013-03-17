export HISTCONTROL=ignoreboth # ignore duplicates and commands starting with white space
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S %z " # history display format
__HISTIGNORE_DEFAULT="h:h *:encfs-*"
export HISTIGNORE="${HISTIGNORE:-$__HISTIGNORE_DEFAULT}"
export HISTFILE=$HOME/.bash_history
export HISTSIZE=262144
unset HISTFILESIZE

# turn history recording on/off
h () {
    if [ "$#" -eq 1 -a "$1" == on ]
    then

        if [ -z "$__HISTIGNORE_SAVED" ]
        then
            HISTIGNORE="$__HISTIGNORE_DEFAULT"
        else
            HISTIGNORE="$__HISTIGNORE_SAVED"
        fi

    elif [ "$#" -eq 1 -a "$1" == off ]
    then

        if [ "$HISTIGNORE" != "*" ]
        then
            __HISTIGNORE_SAVED="$HISTIGNORE"
        fi
        HISTIGNORE="*"

    else

        echo >&2 "usage: h <on|off>"

    fi
}
