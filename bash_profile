## ~/.bash_profile

# Start screen/other, if:
# 1) Attached terminal
# 2) Login shell
# 3) Interactive shell
# 4) Terminal type is set

if tty -s && shopt -q login_shell && [[ "$PS1" ]] && [[ "$TERM" ]] ; then
    echo 'Select initial program to run!'
    echo 'Hit ^D ro run vanilla bash, without exec.'
    select start in "screen -OU -xdR" ; do break ; done
    exec $start
fi

if [[ "$TERM" != "screen" ]] && [[ -r "$HOME"/.bashrc ]] ; then
    . "$HOME"/.bashrc
fi

. $HOME/.bashrc.d/abevjava.sh
