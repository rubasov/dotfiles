inside_git_repo () {
    test "$( git rev-parse --is-inside-work-tree 2>/dev/null )" == "true"
}

# referring to HEAD is an error between git init and 1st commit
#
# fatal: \
# ambiguous argument 'HEAD': unknown revision or path not in the working tree.
# Use '--' to separate paths from revisions
#
# we supress these errors

# http://stackoverflow.com/a/2659808/272744
git_repo_is_clean () {
    git diff-index --quiet HEAD 2>/dev/null
}

# http://stackoverflow.com/questions/6245570
git_current_branch () {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# path to top of git repo
git_repo_top_path () {
    git rev-parse --show-toplevel
}

# relative path to top of git repo
git_rel_path_to_top () {
    git rev-parse --show-prefix
}

# "gittified" cwd:
#     path/to/repo/ [[!]branch] dir/inside/repo
git_cwd () {
    local top_path="$( git_repo_top_path )"
    local branch="$( git_current_branch )"
    local rel_path_to_top="$( git_rel_path_to_top )"
    local cwd

    if git_repo_is_clean
    then
        dirty_flag=""
    else
        dirty_flag="!"
    fi

    cwd=""
    cwd="$cwd""${top_path/#$HOME/~}/"  # abbreviate $HOME to ~
    cwd="$cwd"" [$dirty_flag$branch]"

    rel_path_to_top="${rel_path_to_top%/}"
    if [ ! -z "$rel_path_to_top" ]
    then
        cwd="$cwd"" $rel_path_to_top"
    fi

    builtin echo -ne "$cwd"
}
