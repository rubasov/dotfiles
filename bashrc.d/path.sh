PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin"

# freedesktop.org's idea about where the user's bin/ should be
if [ -d "$HOME/.local/bin" ]
then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ]
then
    PATH="$HOME/bin:$PATH"
fi

# interactive shells
if [[ $- =~ i ]]
then
    PATH="${PATH}:."
fi

# clean up duplicate entries in PATH (leave the first)
PATH=$(                          \
    echo $PATH                   \
        | tr : \\n               \
        | nl                     \
        | sort --key 2 --unique  \
        | sort --key 1 --numeric \
        | cut --characters 8-    \
        | tr \\n :               \
        | sed -e 's/:$/\n/'      \
)

export PATH
