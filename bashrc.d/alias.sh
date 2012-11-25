# FIXME: always think about converting aliases to scripts under ~/bin

alias p="vim $HOME/.x/passwords.asc"
alias bc="bc --mathlib --quiet"

# don't connect to the X server; shortens startup time in a terminal
alias vim="vim -X"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias rgrep="rgrep --color=auto"

if [ 0 -eq $EUID ]
then
    alias cp="cp --interactive"
    alias mv="mv --interactive"
    alias rm="rm --interactive"
else
    # this is in conflict with an iproute binary, but I don't care
    alias ss="exec sudo -s HOME=\"$HOME\" bash"
fi
