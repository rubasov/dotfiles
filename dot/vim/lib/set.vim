""" Plain, static settings, no conditionals, functions, nothing fancy.

""" show/hide stuff

" thanks, I know which mode I'm in
set noshowmode

" current line and column in status line
set ruler

" a few lines of context even when the cursor is near to top or bottom
set scrolloff=3

" no intro
set shortmess+=I

" commands can be pretty long
set showcmd


""" search settings

" ignore case except when /searchContainsCaps
set ignorecase
set smartcase

" incremental search
set incsearch

" highlight matches
set showmatch


""" history

" history size
set history=10000

" :help persistent-undo
set undolevels=1000
set undoreload=10000
set undofile


""" diff

" set huge context for vimdiff to prevent folding
set diffopt+=context:99999
set diffopt+=filler
set diffopt+=foldcolumn:0
set diffopt+=vertical


""" fold

set nofoldenable
set foldcolumn=0


""" misc

" enable backspace usage outside of currently inserted part
set backspace=indent,eol,start

" tab completion mode for file names and commands
" longest:list = like in bash
set wildmode=longest:list

" Don't connect to X. Shortens startup time, but X clipboard can't be
" accessed and window title won't be set.
" :help 'clipboard'
set clipboard=exclude:.*

" highlight current line number
" http://stackoverflow.com/questions/8247243
set cursorline
