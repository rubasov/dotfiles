## The basic prompt looks like this (except the colors):
#
# 23:10:29 user at host
# ~/src/dotfiles/bashrc.d $
#
# 23:11:32 root at host
# ~/src/dotfiles/bashrc.d #
#
## Long (>10s) commands will be timed:
#
# ~ $ sleep 15
# 23:12:13 user at host 15s
#
## Exit codes will be displayed:
#
# ~ $ false
# 23:13:26 user at host $?=1
#
## Human readable exit codes for death by signal:
#
# ~ $ foo^C
# 23:14:16 user at host $?=SIGINT

. "$__bashrc_lib"/libcolor.sh

__signal_max=31 # ignore real-time signals (>31)
for (( i = 1 ; i <= $__signal_max ; ++i ))
do
    __sig_num_to_name[$i]=$( builtin kill -l $i )
done

print_human_exit_status () {
    __ev=$?
    if (( $__ev == 0 ))
    then
        : # be silent on success
    elif (( 128 + 1 <= $__ev && $__ev <= 128 + $__signal_max ))
    then
        # translate $? to signal name
        builtin echo -n ' $?='${__sig_num_to_name[ $(( $__ev & 127 )) ]}
    else
        # print $? as it is by default
        builtin echo -n ' $?='$__ev
    fi
}

# http://stackoverflow.com/questions/1862510
timer_start () {
    __timer=${__timer:-$SECONDS}
}
trap timer_start DEBUG

timer_stop () {
    __timer_display=$(( $SECONDS - $__timer ))
    unset __timer
}

print_time_since_last_prompt () {
    if (( __timer_display >= 10 ))
    then
        builtin echo -n " ${__timer_display}s"
    fi
}

prompt_function () {
    __human_exit_status=$( print_human_exit_status )
    timer_stop
    __time_since_last_prompt=$( print_time_since_last_prompt )
}
PROMPT_COMMAND=prompt_function

if [ 0 -eq $EUID ]
then
    __prompt=$__red
else
    if [ "$USER" = "$LOGNAME" ]
    then
        if [ "$HISTIGNORE" = "*" ]
        then
            __prompt=$__purple
        else
            __prompt=$__green
        fi
    else
        __prompt=$__yellow
    fi
fi

# \t the current time in 24-hour HH:MM:SS format
# \D{format} the current time formatted by strftime(3)

PS1='\[$__reset\]'
PS1="$PS1"'\t \u at \[$__bold\]\h\[$__reset\]'
PS1="$PS1"'$__time_since_last_prompt'
PS1="$PS1"'$__human_exit_status'
PS1="$PS1"'\n\w \[$__prompt\]\$\[$__reset\] '

export PS1
