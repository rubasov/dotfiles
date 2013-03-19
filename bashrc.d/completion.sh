enable_completion () {
    local completion_file="${1:-/etc/bash_completion}"
    if [ -f "$completion_file" ]
    then
        . "$completion_file"
    fi
}
enable_completion
