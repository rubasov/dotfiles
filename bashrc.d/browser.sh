export_preferred_browser () {
    local browser
    for browser in "$@"
    do
        if [ -x $( which "$browser" ) ]
        then
            export BROWSER="$browser"
            break
        fi
    done
}
export_preferred_browser chromium firefox elinks links2 lynx
