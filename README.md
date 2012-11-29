rubasov's dotfiles
==================

These are my random dotfiles for bash, vim and a bunch of other
programs. At this moment they are not meant to be 100% ready for
download-and-use, though a large part of this repo should be close
to that. At least they tend to function with minimal editing at my
workplaces.

The typical environment I use these files in:

* Debian sid
* bash 4.2
* vim 7.3

A few things that may be worth of your attention
------------------------------------------------

1.  Transparent editing of GnuPG-encrypted files in vim.

    See `augroup gpg` near the end of `vimrc`.

2.  bash prompt with wall-clock-runtime and exit code of last command.

    See `bashrc.d/prompt.sh`.

3.  A 256-color vim colorscheme.

    See `vim/colors/experiment.vim`.

4.  Per screen scrolling in GNU screen by mouse wheel or
    by shift+page{up,down} without messing up the scrollback buffer.

    See `screenrc` and `Xresources`.

Credits
-------

Almost all the ideas found in these dotfiles came from some hidden corner
of the web during the last decade. I tried to always mention the source
of my inspriation where it is due, but I'm sure I missed a few places. If
you find an omission, let me know and I happily add it.

See also
--------

[http://dotfiles.github.com/](http://dotfiles.github.com/)
