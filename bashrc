## ~/.bashrc

__bashrc_lib="$HOME/.bashrc.d"
__profiling=off # on/off

if [ "$__profiling" == on ]
then
    __start_date=$( date +%s.%N )
fi

# interactive shells
if [[ $- =~ i ]]
then
    . "$__bashrc_lib"/prompt.sh
    . "$__bashrc_lib"/alias.sh
    . "$__bashrc_lib"/completion.sh
    . "$__bashrc_lib"/history.sh
    . "$__bashrc_lib"/function.sh
    . "$__bashrc_lib"/option.sh
    . "$__bashrc_lib"/editor.sh
    . "$__bashrc_lib"/pager.sh
    . "$__bashrc_lib"/browser.sh
    . "$__bashrc_lib"/mesg.sh
    . "$__bashrc_lib"/stty.sh
    . "$__bashrc_lib"/display.sh
fi

if [ "$__profiling" == on ]
then
    __end_date=$( date +%s.%N )
    printf >&2 ".bashrc interactive part runs for (sec) "
    echo $__end_date-$__start_date |
        bc >&2 --quiet --mathlib
fi

. "$__bashrc_lib"/umask.sh
. "$__bashrc_lib"/perl-local-lib.sh
. "$__bashrc_lib"/proxy.sh
. "$__bashrc_lib"/path.sh
