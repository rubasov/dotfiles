## The basic prompt:
#
# ┌── HH:MM:SS user at host
# └ ~/foo/bar
# $
#
## For root:
#
# ┌── HH:MM:SS root at host
# └ ~/foo/bar
# #
#
## Long (>10s) commands are timed:
#
# $ sleep 15
# ┌── HH:MM:SS user at host 15s
# └ ~/foo/bar
# $
#
## Exit codes are displayed:
#
# $ false
# ┌── HH:MM:SS user at host $?=1
# └ ~/foo/bar
# $
#
## Exit codes for death by signal are human readable:
#
# $ sh -c 'kill -TERM $$'
# ┌── HH:MM:SS user at host $?=SIGTERM
# └ ~/foo/bar
# $
#
## Branch and dirty flag (!) are displayed for git repositories:
#
# ┌── HH:MM:SS user at host
# └ ~/src/foo/ [!master] bar
# $


. "$__bashrc_lib"/libcolor.sh
. "$__bashrc_lib"/libexitcode.sh
. "$__bashrc_lib"/libgit.sh
. "$__bashrc_lib"/libtimer.sh ; timer_setup_trap

cwd () {
    if inside_git_repo
    then
        git_cwd

    else
        builtin echo -ne "${PWD/#$HOME/~}"

    fi
}

wrap () {
    if [ "$2" != "" ]
    then
        builtin echo -n "${1}${2}${3}"
    fi
}

prompt_function () {
    local exit_code=$?
    timer_stop

    __fragment_time="$( wrap ' ' "$( took_at_least 10 )" 's' )"
    __fragment_exit="$( wrap ' $?=' "$( exit_code_human $exit_code )" '' )"
    __fragment_cwd="$( cwd )"

    return $exit_code
}
PROMPT_COMMAND=prompt_function

if [ 0 -eq $EUID ]
then
    __prompt=$__red
else
    if [ "$USER" = "$LOGNAME" ]
    then
        if [ "$SHLVL" -gt 1 ]
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

PS1=''
PS1="$PS1"'\[$__reset\]'
PS1="$PS1"$'\342\224\214'  # unicode box drawing: ┌
PS1="$PS1"$'\342\224\200'  # unicode box drawing: ─
PS1="$PS1"$'\342\224\200'  # unicode box drawing: ─
PS1="$PS1"' '
PS1="$PS1"'\t \u at \h'
PS1="$PS1"'\[$__red\]$__fragment_exit\[$__reset\]'
PS1="$PS1"'$__fragment_time'
PS1="$PS1"'\n'
PS1="$PS1"$'\342\224\224'  # unicode box drawing: └
PS1="$PS1"' '
PS1="$PS1"'$__fragment_cwd'
PS1="$PS1"'\n'
PS1="$PS1"'\[$__prompt\]\$\[$__reset\]'
PS1="$PS1"' '

export PS1
