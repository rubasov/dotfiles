rubasov's dotfiles
==================

These are my random dotfiles for bash, vim and a bunch of other
programs. At this moment they are not meant to be 100% ready for
download-and-use, though a large part of this repo should be close
to that. At least they tend to function with minimal editing at my
workplaces.

The typical environment I use these files:

* Debian/sid
* bash 4.2
* vim 7.3

A few things that may be worth of your attention
------------------------------------------------

1. Transparent editing of GnuPG-encrypted files in vim.

See 'augroup gpg' near the end of vimrc .

2. bash prompt with wall-clock-runtime and exit code of last command.

See bashrc.d/prompt.sh .

3. A 256-color vim colorscheme.

See vim/colors/experiment.vim .

4. Per screen scrolling in GNU screen by mouse wheel or
   by shift+page{up,down} without messing up the scrollback buffer.

See screenrc and Xresources .
