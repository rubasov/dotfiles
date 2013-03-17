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

" current line and column
set ruler

" no intro
set shortmess+=I

" commands can be pretty long
set showcmd

" highlight matches
set showmatch

" show a few lines of context even when the cursor is near to top or bottom
set scrolloff=3


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

" create directories before use: mkdir, chmod 700
let s:dir = "~/var/lib/vim"
if isdirectory(expand(s:dir))

    if &directory =~# '^\.,'
        let &directory = expand(s:dir) . "/swap," . &directory
    endif

    if &backupdir =~# '^\.,'
        let &backupdir = expand(s:dir) . "/backup," . &backupdir
    endif

    " :help presistent-undo
    let &undodir = expand(s:dir) . "/undo,"
    set undolevels=1000
    set undoreload=10000
    set undofile

endif


""" visible tabs and trailing whitespace

" use utf-8 to make them stand out
" U+00b7 Middle dot (·)
" U+2022 Bullet (•)
" one way to enter them is: <C-v>uNNNN
" where NNNN is the unicode code point
set encoding=utf-8
let &listchars="tab:\u2022\u00b7,trail:\u00b7,nbsp:\u00b7"

" use ascii
"set listchars=tab:>-,trail:-


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


""" load plugins

" :set runtimepath?

" https://github.com/tpope/vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" plugin setup example (nerdcommenter)
"
" mkdir -p ~/src/github/scrooloose
" cd ~/src/github/scrooloose
" git clone https://github.com/scrooloose/nerdcommenter.git
" mkdir -p ~/.vim/bundle
" cd ~/.vim/bundle
" ln -s ~/src/github/scrooloose/nerdcommenter .
"
" After this pathogen should load nerdcommenter.
"
" You can enable/disable a plugin by removing/recreating the symlink.


""" configure plugins

" syntax color complex things like @{${"foo"}}
autocmd FileType perl let perl_extended_vars = 1

autocmd FileType python let python_highlight_all = 1

" put python docstring in the comment highlighter category
" FIXME this overshoots, should handle "foo" and """foo""" differently
"hi def link pythonString Comment
"hi def link pythonUniString Comment


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



""" languages

" FIXME consider moving this to ~/.vim/ftplugin/

" query currently recognized language
" http://stackoverflow.com/questions/5324971
"
" :set filetype?
" :set ft?

" defaults
for s:filetype in
    \ [ "c", "cpp", "gitcommit", "lisp", "make", "perl",
    \   "python", "sh", "sql", "mysql", "vim" ]

    " http://vimdoc.sf.net/htmldoc/options.html#'colorcolumn'
    exe "autocmd FileType" s:filetype "set colorcolumn=+1"

    " tab keypress in insert mode will insert spaces
    exe "autocmd FileType" s:filetype "set expandtab"

    " make extraneous whitespace visible
    exe "autocmd FileType" s:filetype "set list"

    " show line numbers
    exe "autocmd FileType" s:filetype "set number"

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
autocmd FileType make set noexpandtab
autocmd FileType python set textwidth=79

filetype on
filetype plugin on
filetype indent on


""" functions

" I haven't found a usable python pretty printer.
" But we have the pep8 utility to do at least half of the work.
function! Pep8Filter()
    silent exe "%!pep8 /dev/stdin"
    if v:shell_error == 1
        let l:format_error = join( getline( line("'["), line("']") ), "\n" )
        echo l:format_error
    endif
    undo
endfunction

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
            exe "%!perltidy" b:perltidy_options
        elseif b:current_syntax == 'python'
            call Pep8Filter()
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

    " default options
    let b:perltidy_options = "--quiet"

    if match( expand("%:p:h"), "/project-foo/" ) >= 0
        let b:perltidy_options = b:perltidy_options
            \ . "--profile=$HOME/.perltidyrc-foo"
    elseif match( expand("%:p:h"), "/project-bar/" ) >= 0
        let b:perltidy_options = b:perltidy_options
            \ . "--profile=$HOME/.perltidyrc-bar"
    endif

endfunction

autocmd BufRead,BufNewFile * call SetProjectVars()

" call it even if filetype was not detected automatically,
" but set manually (:set ft=...)
autocmd FileType * call SetProjectVars()

function! ProgrammingFriendly()
    filetype detect
endfunction

function! CopyPasteFriendly()
    set nonumber
    set colorcolumn=
    set nolist
endfunction


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

" shortcut for vsplit-switch-open
nnoremap <leader>e :vsplit<Enter><C-w><C-w>:e

" mnemonic: nm as in :set NuMber
nnoremap <silent> <leader>nm :call ProgrammingFriendly()<Enter>

" mnemonic: nn as in :set NoNumber
nnoremap <silent> <leader>nn :call CopyPasteFriendly()<Enter>

" reload vimrc
" mnemonic: r as in Reload
nnoremap <leader>r :source ~/.vimrc<Enter>

" tidy whole file
" mnemonic: t as in Tidy
nnoremap <silent> <leader>t :call PrettyPrint()<Enter>

" tidy selected lines (Perl-only)
" http://stackoverflow.com/questions/9202063
vnoremap <silent> <leader>t :!perltidy <C-r>=b:perltidy_options<Enter><Enter>

" write with sudo
" http://stackoverflow.com/questions/2600783
nnoremap <silent> <leader>w :w !sudo tee %<Enter>

" fix my regular error of typing upper case :W / :Q instead of lower case
" http://stackoverflow.com/questions/3878692
command! Q q
command! W w


""" transparent editing of GnuPG-encrypted files
"
" FIXME consider moving this to ~/.vim/ftplugin/

" generate keypair before use: gpg --gen-key
" https://www.antagonism.org/privacy/gpg-vi.shtml
augroup gpg

    function! SavePosition()
        let s:save_cursor = getpos('.')
        normal H
        let s:save_top = getpos('.')
    endfunction

    function! RestorePosition()
        call setpos('.', s:save_top)
        normal zt
        call setpos('.', s:save_cursor)
    endfunction

    function! GpgReadPre()
        set viminfo=   " no .viminfo file
        set noswapfile " no vim swap file
        set noundofile " no vim undo file
        set bin        " .gpg is a binary format
    endfunction

    function! GpgReadPost()
        %!gpg --decrypt 2>/dev/null
        set nobin
        redraw!
    endfunction

    function! GpgWritePre()
        call SavePosition()
        set bin
        if match( expand("%"), "\.asc$" ) >= 0
            %!gpg --default-recipient-self --encrypt --armor
        elseif match( expand("%"), "\.gpg$" ) >= 0
            %!gpg --default-recipient-self --encrypt
        endif
    endfunction

    function! GpgWritePost()
        undo " undo the encryption so we are back to plaintext
        set nobin
        call RestorePosition()
        redraw! " suppress prompt (Press ENTER or type command to continue)
    endfunction

    function! GpgVimLeave()
        " Clear the terminal screen and screen's scrollback buffer.
        " This is incomplete, the file content may remain in
        " a few buffers, e.g. in the terminal scrollback buffer.

        " FIXME 2012-11-29 rubasov: eliminate magic number 65536
        "       After clearing screen's scrollback buffer the original buffer
        "       size should be restored, not 65536.
        exe "! echo $TERM | grep -q screen"
            \ "&& screen -X scrollback 0 ; screen -X scrollback 65536"
        !clear
    endfunction

    autocmd!
    autocmd BufReadPre,FileReadPre     *.asc,*.gpg call GpgReadPre()
    autocmd BufReadPost,FileReadPost   *.asc,*.gpg call GpgReadPost()
    autocmd BufWritePre,FileWritePre   *.asc,*.gpg call GpgWritePre()
    autocmd BufWritePost,FileWritePost *.asc,*.gpg call GpgWritePost()
    autocmd VimLeave                   *.asc,*.gpg call GpgVimLeave()

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
