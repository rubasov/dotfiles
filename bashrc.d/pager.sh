export PAGER=less
export LESS="--ignore-case --RAW-CONTROL-CHARS"
test -x $( which lesspipe ) &&
    eval $( lesspipe )
