set -o vi

shopt -s checkhash    # reduce path searches
shopt -s checkwinsize # allow resizing of xterm running bash
shopt -s cmdhist      # save multiline commands as one liner to the history
#shopt -s compat31     # see BASHFAQ E14 on quoted patterns for the =~ operator
shopt -s histappend   # append to history file
shopt -s histverify   # verify history expansion
