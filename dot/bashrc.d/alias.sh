# FIXME Always think about converting aliases to scripts under ~/bin .

alias bc="bc --mathlib --quiet"

if [ 0 -eq $EUID ]
then
    alias cp="cp --interactive"
    alias mv="mv --interactive"
    alias rm="rm --interactive"

else
    # The name ss conflicts with a binary in the
    # Debian iproute package, but I don't care.

    # XXX I rarely use this environment as root nowadays so the
    #     consequences of setting root's home may be surprising.
    alias ss="exec sudo -s HOME=\"$HOME\" bash"

fi
