""" vimscript documentation
"
" tutorial:
" http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html
"
" reference:
" http://vimdoc.sf.net/htmldoc/usr_41.html


""" variable scoping
"
" g:varname  global
" s:varname  local to current script file
" w:varname  local to current editor window
" t:varname  local to current editor tab
" b:varname  local to current editor buffer
" l:varname  local to current function
" a:varname  parameter of current function
" v:varname  predefined by vim


""" try to make sourcing vimrc idempotent :source ~/.vimrc

" clear autocmds to avoid duplication
autocmd!

" to supress redefinition errors, below you'll see definitions like:
"
" function!
" command!


""" sometimes comes handy

" per-file vim settings (use with care)
"set modeline


""" show/hide stuff

" thanks, I know which mode I'm in
set noshowmode

" line numbers
set number

" current line and column
set ruler

" no intro
set shortmess+=I

" commands can be pretty long
set showcmd

" highlight matches
set showmatch


""" search settings

" ignore case except when /searchContainsCaps
set ignorecase
set smartcase

" incremental search
set incsearch

" Fight vim's defaults of what's literal and what's magic in a regex.
" \v makes the following regex "very magic", that is everything is magic
" except _0-9A-Za-z. This seems the closest to an extended regular
" expressions, like in egrep.
"
" See also :help magic .
"
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v


""" history

" history size
set history=65536


""" visible tabs and trailing whitespace

" use utf-8 to make them stand out
set encoding=utf-8
set listchars=tab:»·,trail:·

" use ascii
"set listchars=tab:>-,trail:-

" turn it on
set list

" turn it off if it conflicts with copy-paste
" set nolist


""" gvim

" font
set guifont="Terminus 14"

" no menu bar
set guioptions-=m

" no toolbar
set guioptions-=T

" no scrollbars
set guioptions-=b " bottom
set guioptions-=l " left
set guioptions-=r " right


""" misc input hackery

" enable backspace usage outside of currently inserted part
set backspace=indent,eol,start

" tab completion mode for file names and commands
" longest:list = like in bash
set wildmode=longest:list

" easy paste mode toggling
" gvim can detect pasting, but vim in a terminal cannot
set pastetoggle=<F12>


""" colors

" 256-color support
" http://vim.wikia.com/wiki/256_colors_in_vim
set t_Co=256

" syntax highlighting
syntax on

" 16 color
"colorscheme slate

" 256 color
colorscheme experiment

" extra visual guide against long lines
set colorcolumn=81


""" languages

" FIXME consider moving this to ~/.vim/ftplugin/

" query currently recognized language
" http://stackoverflow.com/questions/5324971
"
" :set filetype?

" defaults
for s:filetype in
    \ [ "c", "cpp", "lisp", "make", "perl", "python", "sh", "vim" ]

    " tab keypress in insert mode will insert spaces
    exe "autocmd FileType" s:filetype "set expandtab"

    " http://vimdoc.sf.net/htmldoc/options.html#'shiftwidth'
    exe "autocmd FileType" s:filetype "set shiftwidth=4"

    " http://vimdoc.sf.net/htmldoc/options.html#'softtabstop'
    exe "autocmd FileType" s:filetype "set softtabstop=4"

    " display tabs already in source according to <tabstop>
    exe "autocmd FileType" s:filetype "set tabstop=8"

    " hard wrap lines after <textwidth> columns (insert newline)
    exe "autocmd FileType" s:filetype "set textwidth=78"

endfor

" override the defaults if needed
autocmd FileType c set nolist
autocmd FileType cpp set nolist
autocmd FileType make set nolist
autocmd FileType make set noexpandtab
autocmd FileType python set textwidth=79

filetype on
filetype plugin on
filetype indent on


""" plugin config

" syntax color complex things like @{${"foo"}}
autocmd FileType perl let perl_extended_vars = 1

" http://www.vim.org/scripts/script.php?script_id=1230
autocmd FileType lisp runtime plugin/RainbowParenthsis.vim


""" functions

" filter the buffer through pretty printer, code beautifier
" keep cursor position as expressed in terms of line/column
function! PrettyPrint()

    " save position of cursor
    let s:save_cursor = getpos('.')

    " save position of window top
    normal! H
    let s:save_top = getpos('.')

    if exists("b:current_syntax")

        if b:current_syntax == 'perl'
            execute "%!perltidy " . b:perltidy_options
        elseif b:current_syntax == 'python'
            " http://pypi.python.org/pypi/PythonTidy/
            %!PythonTidy.py
        elseif b:current_syntax == 'c' || b:current_syntax == 'cpp'
            " FIXME when an error msg is printed to stderr
            "       it gets into the buffer, though it shouldn't
            " alternative: uncrustify
            %!indent
        elseif b:current_syntax == 'xml'
            " alternative: xmllint, tidy
            %!xmlstarlet format
        "elseif b:current_syntax == 'html'
        "    %!tidy --indent
        "elseif b:current_syntax == 'xhtml'
        "    %!tidy --indent
        elseif b:current_syntax == 'lisp'
            %!lispindent.lisp
        endif

    endif

    " restore saved position of window top
    call setpos('.', s:save_top)

    " restore saved position of cursor
    normal zt
    call setpos('.', s:save_cursor)

endfunction

" set project-specific variables based on the path of the project
" http://stackoverflow.com/questions/9202063
function! SetProjectVars()

    " help to comprehend expand("%:p:h")
    "
    "  % = current file name
    " :p = expand to full path
    " :h = head (last path component removed)
    "
    " see also: http://vimdoc.sf.net/htmldoc/eval.html#expand()

    if match( expand("%:p:h"), "/project-foo/" ) >= 0
        let b:perltidy_options = "--profile=$HOME/.perltidyrc-foo --quiet"
    elseif match( expand("%:p:h"), "/project-bar/" ) >= 0
        let b:perltidy_options = "--profile=$HOME/.perltidyrc-bar --quiet"
    else
        let b:perltidy_options = "--quiet"
    endif

endfunction

autocmd BufRead,BufNewFile * call SetProjectVars()


""" mappings
"
" Help to decode map commands:
"
" map is recursive.
" noremap is non-recursive.
"
" The extra char at the beginning (e.g. [nv]map) stands for the
" mode in which the mapping applies. n - normal, v - visual.
"
" For more info see :help :map-modes .

let g:mapleader = ','

" force filetype (re-)detection
" mnemonic: d as in Detect
nnoremap <silent> <leader>d :filetype detect<Enter>

" programming-friendly mode
" mnemonic: nm as in :set NuMber
nnoremap <silent> <leader>nm
    \ :set number<Enter>
    \ :set colorcolumn=80<Enter>
    \ :set list<Enter>
    \ :filetype detect<Enter>

" clutter-free copy-paste-friendly mode
" mnemonic: nn as in :set NoNumber
nnoremap <silent> <leader>nn
    \ :set nonumber<Enter>
    \ :set colorcolumn=<Enter>
    \ :set nolist<Enter>

" reload vimrc
" mnemonic: r as in Reload
nnoremap <leader>r :source ~/.vimrc<Enter>

" tidy whole file
" mnemonic: t as in Tidy
nnoremap <silent> <leader>t :call PrettyPrint()<Enter>

" tidy selected lines (Perl-only)
" http://stackoverflow.com/questions/9202063
vnoremap <silent> <leader>t :!perltidy <C-r>=b:perltidy_options<Enter><Enter>

" quick vsplit-switch-open
nnoremap <leader>v :vsplit<Enter><C-w><C-w>:e 

" write with sudo
" http://stackoverflow.com/questions/2600783
nnoremap <silent> <leader>w :w !sudo tee %<Enter>

" fix my regular error of typing :W instead of :w
" http://stackoverflow.com/questions/3878692
command! W w


""" transparent editing of GnuPG-encrypted files

" generate keypair before use: gpg --gen-key
" https://www.antagonism.org/privacy/gpg-vi.shtml
augroup gpg

    autocmd!

    " do not use ~/.viminfo
    autocmd BufReadPre,FileReadPre *.gpg,*.asc set viminfo=
    " do not use a swap file
    autocmd BufReadPre,FileReadPre *.gpg,*.asc set noswapfile

    " switch to binary mode to read the binary pgp format
    autocmd BufReadPre,FileReadPre *.gpg set bin
    autocmd BufReadPre,FileReadPre *.gpg,*.asc
        \ let cmdheight_save = &cmdheight|set cmdheight=2
    autocmd BufReadPost,FileReadPost *.gpg,*.asc
        \ '[,']!sh -c 'gpg --decrypt 2>/dev/null'

    " switch to normal mode for editing
    autocmd BufReadPost,FileReadPost *.gpg set nobin
    autocmd BufReadPost,FileReadPost *.gpg,*.asc
        \ let &cmdheight = cmdheight_save|unlet cmdheight_save|redraw!
    autocmd BufReadPost,FileReadPost *.gpg,*.asc
        \ execute ":doautocmd BufReadPost " . expand("%:r")

    " save position before filtering through gpg
    autocmd BufWritePre,FileWritePre *.gpg,*.asc
        \ let s:save_cursor = getpos('.')
    autocmd BufWritePre,FileWritePre *.gpg,*.asc
        \ normal! H
    autocmd BufWritePre,FileWritePre *.gpg,*.asc
        \ let s:save_top = getpos('.')

    " encrypt text before writing
    autocmd BufWritePre,FileWritePre *.gpg set bin
    autocmd BufWritePre,FileWritePre *.gpg
        \ '[,']!sh -c 'gpg --default-recipient-self --encrypt 2>/dev/null'
    autocmd BufWritePre,FileWritePre *.asc
        \ '[,']!sh -c 'gpg --default-recipient-self --encrypt --armor 2>/dev/null'
    " undo the encryption so we are back in the normal text
    autocmd BufWritePost,FileWritePost *.gpg,*.asc u

    " restore position
    autocmd BufWritePost,FileWritePost *.gpg,*.asc
        \ call setpos('.', s:save_top)
    autocmd BufWritePost,FileWritePost *.gpg,*.asc
        \ normal zt
    autocmd BufWritePost,FileWritePost *.gpg,*.asc
        \ call setpos('.', s:save_cursor)

    " clear the terminal screen and screen's scrollback buffer
    " this is best effort only, the file content may remain in
    " a few buffers, e.g. in the terminal scrollback buffer
    autocmd VimLeave *.gpg,*.asc
        \ !sh -c 'screen -X scrollback 0 ; screen -X scrollback 65536'
    autocmd VimLeave *.gpg,*.asc !clear

augroup end


""" yet another way to show tabs and trailing whitespace

" This is copy-paste friendly, unlike listchars, it also doesn't show
" trailing whitespace when you're in the middle of typing something in insert
" mode, but it is much much more noisier visually.

" make trailing whitespace visible
" http://blog.kamil.dworakowski.name/2009/09/
"     \ unobtrusive-highlighting-of-trailing.html
"
""autocmd ColorScheme * highlight ExtraWhitespace guibg=red
"highlight ExtraWhitespace ctermbg=232
"autocmd BufEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

" make tabs visible
"
""autocmd ColorScheme * highlight Tab guibg=red
"highlight Tab ctermbg=232
"autocmd BufEnter * match Tab /\t/
