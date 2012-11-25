# PERL5LIB="$HOME/lib/perl${PERL5LIB:+":$PERL5LIB"}"
# (cf) env -i perl -Mlocal::lib=$HOME
eval $( perl -Mlocal::lib=$HOME | grep -vw PATH )
