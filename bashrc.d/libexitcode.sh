sig_num_to_name () {
    builtin kill -l "$1"
}

exit_code_human () {
    local exit_code="$1"

    # ignore real-time signals (>31)
    local signal_max=31

    if (( $exit_code == 0 ))
    then
        : # be silent on success
    elif (( 128 + 1 <= $exit_code && $exit_code <= 128 + $signal_max ))
    then
        # translate exit code to signal name
        builtin echo -n "$( sig_num_to_name $(( $exit_code & 127 )) )"
    else
        # leave exit code as it is by default
        builtin echo -n $exit_code
    fi
}
