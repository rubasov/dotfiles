export PAGER=less

# --quit-if-one-screen
export LESS="--ignore-case --RAW-CONTROL-CHARS"

test -x $( which lesspipe ) &&
    eval $( lesspipe )
