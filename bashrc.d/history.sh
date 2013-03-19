HISTFILE="$HOME"/.bash_history

# store unlimited number of commands in HISTFILE
unset HISTFILESIZE

# number of commands to remember
HISTSIZE=999999

HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S %z "

# ignore duplicates and commands starting with white space
HISTCONTROL=ignoreboth

# hide the fact that the user reached out for a tool to hide something
__HISTIGNORE_DEFAULT="e:h"

# if HISTIGNORE was present in the environment use it, otherwise use default
HISTIGNORE="${HISTIGNORE:-$__HISTIGNORE_DEFAULT}"

# toggle history recording on/off
h () {
    # off -> on
    if [ "$HISTIGNORE" == "*" ]
    then
        HISTIGNORE="${__HISTIGNORE_SAVED:-$__HISTIGNORE_DEFAULT}"

    # on -> off
    elif [ "$HISTIGNORE" != "*" ]
    then
        __HISTIGNORE_SAVED="$HISTIGNORE"
        HISTIGNORE="*"

    fi

    echo HISTIGNORE="$HISTIGNORE"
}
