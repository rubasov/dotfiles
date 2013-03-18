# FIXME always think about converting aliases to scripts under ~/bin

alias bc="bc --mathlib --quiet"

# Don't connect to the X server. Shortens startup time in a terminal.
alias vim="vim -X"

if [ 0 -eq $EUID ]
then
    alias cp="cp --interactive"
    alias mv="mv --interactive"
    alias rm="rm --interactive"
else
    # This has the same name as a binary in the
    # Debian iproute package, but I don't care.
    alias ss="exec sudo -s HOME=\"$HOME\" bash"
fi
