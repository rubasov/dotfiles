export PAGER=less

# --quit-if-one-screen
export LESS="--ignore-case --RAW-CONTROL-CHARS"

if [ -x $( which lesspipe ) ]
then
    eval $( lesspipe )
fi
