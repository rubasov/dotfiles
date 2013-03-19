# avoid hardcoding ANSI color codes
__reset=${__reset:-$( tput sgr0 )}
__bold=${__bold:-$( tput bold )}
__red=${__red:-$( tput setaf 1 )}
__green=${__green:-$( tput setaf 2 )}
__yellow=${__yellow:-$( tput setaf 3 )}
__purple=${__purple:-$( tput setaf 5 )}
