## miscellaneous public functions

ckdir () {
    mkdir -p "$@"
    cd "$1"
}

# join 2nd and later arguments by 1st argument
join () {

    # Could be much simpler if it was enough for $1 to be a single char.
    #
    # local IFS="$1"
    # shift
    # builtin echo "$*"

    local sep="$1"
    shift

    builtin echo -n $1
    shift

    for arg in "$@"
    do
        builtin echo -n "$sep$arg"
    done

    builtin echo
}
