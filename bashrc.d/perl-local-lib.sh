# (cf) env -i perl -Mlocal::lib=$HOME
eval $( perl -Mlocal::lib="$HOME" | grep -vw PATH )
