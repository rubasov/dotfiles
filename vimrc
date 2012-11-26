" vim script documentation
" http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html
" http://vimdoc.sf.net/htmldoc/usr_41.html

"" settings for vim

" per-file vim settings
"set modeline

" no intro
set shortmess+=I

" thanks, I know which mode I'm in
set noshowmode

" commands can be pretty long
set showcmd

" highlight matches
set showmatch

" show current line and column
set ruler

" ignore case when searching except /search contains CAPS<CR> (nvi set iclower)
set ignorecase
set smartcase

" incremental search
set incsearch

" history size
set history=65536

" tab completion mode for file names and commands
" longest:list = like in bash
set wildmode=longest:list

" enable backspace usage outside of currently inserted part
set backspace=2

" set up tab and trailing whitespace display
set encoding=utf-8
set listchars=tab:»·,trail:· " use utf-8 to make them stand out
"set listchars=tab:>-,trail:- " use ascii
set list " turn it on
" turn it off by 'set nolist' if it conflicts with copy-paste

" 256 color support
" http://vim.wikia.com/wiki/256_colors_in_vim
set t_Co=256

" easy toggling paste mode
" gvim can detect pasting, but vim in a terminal cannot
set pastetoggle=<F12>

"" settings for gvim

" font
set guifont=Terminus\ 14
"
" remove menu bar from gvim
set guioptions-=m
"
" remove toolbar from gvim
set guioptions-=T
"
" remove scrollbars from gvim
set guioptions-=l
set guioptions-=r
set guioptions-=b

" remove autocommands for the current group
" don't duplicate autocmds when you re-source .vimrc
autocmd!

" enable syntax highlighting
syntax on

"colorscheme slate " 16 color
colorscheme experiment " 256 color

" query currently recognized language by
" http://stackoverflow.com/questions/5324971/vims-current-highlighed-language
" :set filetype?

" language specific settings
"     tabbing settings, that is:
"         display tabs already in source as 8 space wide,
"         but always expand tabs pressed in insert mode to 4 spaces
"     hard wrap lines after 78 columns (insert newline)
" TODO http://vim.wikia.com/wiki/Keep_your_vimrc_file_clean
autocmd FileType c\|cpp\|lisp\|perl\|python\|sh\|vim set softtabstop=4
autocmd FileType c\|cpp\|lisp\|perl\|python\|sh\|vim set shiftwidth=4
autocmd FileType c\|cpp\|lisp\|perl\|python\|sh\|vim set tabstop=8
autocmd FileType c\|cpp\|lisp\|perl\|python\|sh\|vim set expandtab
autocmd FileType c\|cpp\|lisp\|perl\|sh\|vim set textwidth=78

autocmd FileType c\|cpp set nolist " don't make tabs visible

" http://www.vim.org/scripts/script.php?script_id=1230
autocmd FileType lisp runtime plugin/RainbowParenthsis.vim

autocmd FileType make set nolist
autocmd FileType make set tabstop=4
autocmd FileType make set noexpandtab
autocmd FileType make set textwidth=78

" syntax color complex things like @{${"foo"}}
autocmd FileType perl let perl_extended_vars = 1

autocmd FileType python set textwidth=79

filetype on
filetype plugin on

" auto indentation
filetype indent on

function! PrettyPrint()

    " saved position of cursor
    let s:save_cursor = getpos('.')

    " saved position of window top
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

    if match( expand("%:p:h"), "/project-foo/" ) >= 0
        let b:perltidy_options = "--profile=$HOME/.perltidyrc-foo --quiet"
    elseif match( expand("%:p:h"), "/project-bar/" ) >= 0
        let b:perltidy_options = "--profile=$HOME/.perltidyrc-bar --quiet"
    else
        let b:perltidy_options = "--quiet"
    endif

endfunction

autocmd BufRead,BufNewFile * call SetProjectVars()

" sh/perl comment/uncomment blocks of code (in vmode)
" NOTE: this was replaced by NERD commenter
"vmap ,c :s/^/#/gi<Enter>
"vmap ,C :s/^#//gi<Enter>

" NERD commenter shortcut prefix
" http://www.vim.org/scripts/script.php?script_id=1218
let g:mapleader = ','

" force filetype detection (mnemonic: d as in detect)
noremap <silent> ,d :filetype detect<Enter>

" tidy whole file (mnemonic: t as in tidy)
nnoremap <silent> ,t :call PrettyPrint()<Enter>

" tidy selected lines (Perl-only)
" http://stackoverflow.com/questions/9202063
vnoremap <silent> ,t :!perltidy <C-r>=b:perltidy_options<Enter><Enter>

" write with sudo
noremap <silent> ,w :w !sudo tee %<Enter>

" transparent editing of GnuPG-encrypted files
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
    autocmd BufWritePre,FileWritePre *.gpg,*.asc let s:save_cursor = getpos('.')
    autocmd BufWritePre,FileWritePre *.gpg,*.asc normal! H
    autocmd BufWritePre,FileWritePre *.gpg,*.asc let s:save_top = getpos('.')

    " encrypt text before writing
    autocmd BufWritePre,FileWritePre *.gpg set bin
    autocmd BufWritePre,FileWritePre *.gpg
        \ '[,']!sh -c 'gpg --default-recipient-self --encrypt 2>/dev/null'
    autocmd BufWritePre,FileWritePre *.asc
        \ '[,']!sh -c 'gpg --default-recipient-self --encrypt --armor 2>/dev/null'
    " undo the encryption so we are back in the normal text
    autocmd BufWritePost,FileWritePost *.gpg,*.asc u

    " restore position
    autocmd BufWritePost,FileWritePost *.gpg,*.asc call setpos('.', s:save_top)
    autocmd BufWritePost,FileWritePost *.gpg,*.asc normal zt
    autocmd BufWritePost,FileWritePost *.gpg,*.asc call setpos('.', s:save_cursor)

    " clear the terminal screen and screen's scrollback buffer
    " this is best effort only, the file content may remain in
    " a few buffers, e.g. in the terminal scrollback buffer
    autocmd VimLeave *.gpg,*.asc
        \ !sh -c 'screen -X scrollback 0 ; screen -X scrollback 65536'
    autocmd VimLeave *.gpg,*.asc !clear
augroup end

"" yet another way to show tabs and trailing whitespace:
"" This is copy-paste friendly, unlike listchars, it also doesn't show
"" trailing whitespace when you're in the middle of typing something in insert
"" mode, but it is much much more noisier visually.
"
"" make trailing whitespace visible
"" http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html
""autocmd ColorScheme * highlight ExtraWhitespace guibg=red
"highlight ExtraWhitespace ctermbg=232
"autocmd BufEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/
"
"" make tabs visible
""autocmd ColorScheme * highlight Tab guibg=red
"highlight Tab ctermbg=232
"autocmd BufEnter * match Tab /\t/
