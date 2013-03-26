# http://stackoverflow.com/questions/1862510
timer_start () {
    __timer=${__timer:-$SECONDS}
}

timer_stop () {
    __time_since_last_prompt=$(( $SECONDS - $__timer ))
    unset __timer
}

timer_setup_trap () {
    trap timer_start DEBUG
}

took_at_least () {
    local at_least=${1:-10}  # seconds

    if [ "$at_least" -le $__time_since_last_prompt ]
    then
        builtin echo -n $__time_since_last_prompt
    fi
}
