PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin"

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
PATH=$(                     \
    echo $PATH              \
        | tr : \\n          \
        | nl                \
        | sort -u -k 2      \
        | sort -k 1         \
        | cut -c 8-         \
        | tr \\n :          \
        | sed -e 's/:$/\n/' \
)

export PATH
