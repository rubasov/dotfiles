export PAGER=less

# --quit-if-one-screen
export LESS="--ignore-case --RAW-CONTROL-CHARS"

if which lesspipe >/dev/null 2>/dev/null
then
    eval $( lesspipe )
fi
