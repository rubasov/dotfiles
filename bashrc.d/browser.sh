for __browser in chromium firefox elinks links2 lynx
do
    if [ -x $( which $__browser ) ]
    then
        export BROWSER=$__browser
        break
    fi
done
