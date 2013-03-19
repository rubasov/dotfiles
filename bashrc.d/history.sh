# bash has bad history-related defaults: If you occasionally start
# 'bash --norc' it will truncate your .bash_history, so we have to keep
# our history somewhere else if we don't want to lose it occasionally.
HISTFILE="$HOME"/.bash_eternal_history

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
