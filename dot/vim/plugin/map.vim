""" mappings

" Help to decode map commands:
"
" map is recursive.
" noremap is non-recursive.
"
" The extra char at the beginning (e.g. [nv]map) stands for the
" mode in which the mapping applies. n - normal, v - visual.
"
" For more info see :help :map-modes .

let g:mapleader = ","

" fix my regular error of typing upper case :W / :Q instead of lower case
" http://stackoverflow.com/questions/3878692
command! Q q
command! W w

" easy paste mode toggling
" gvim can detect pasting, but vim in a terminal cannot
set pastetoggle=<F12>

" Fight vim's defaults of what's literal and what's magic in a regex.
" \v makes the following regex "very magic", that is everything is magic
" except _0-9A-Za-z. This seems the closest to an extended regular
" expressions, like in egrep.
"
" :help magic
"
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" force filetype (re-)detection
" mnemonic: d as in Detect
nnoremap <silent> <leader>d :filetype detect<Enter>

" shortcut for vsplit-switch-open
nnoremap <leader>e :vsplit<Enter><C-w><C-w>:e

" jump forward and back between diff hunks
" mnemonic: hp as in Hunk Previous
" mnemonic: hn as in Hunk Next
nnoremap <silent> <leader>hp [c
nnoremap <silent> <leader>hn ]c

" mnemonic: nm as in :set NuMber
nnoremap <silent> <leader>nm :call ProgrammingFriendly()<Enter>

" mnemonic: nn as in :set NoNumber
nnoremap <silent> <leader>nn :call CopyPasteFriendly()<Enter>

" reload vimrc
" mnemonic: r as in Reload
nnoremap <leader>r :source ~/.vimrc<Enter>

" slime mappings
" https://github.com/jpalardy/vim-slime/pull/12#issuecomment-4674698
"
" disable the default emacs-like mappings
let g:slime_no_mappings = 1
"
" enable vi-like mappings
" mnemonic: s as in Send
" mnemonic: ss is analogous to dd/yy/...
" mnemonic: sv as in Slime Variables
vmap <silent> <leader>s <Plug>SlimeRegionSend
nmap <silent> <leader>s <Plug>SlimeSend
nmap <silent> <leader>ss <Plug>SlimeLineSend
nmap <silent> <leader>sv <Plug>SlimeConfig

" tidy whole file
" mnemonic: t as in Tidy
nnoremap <silent> <leader>t :call PrettyPrint()<Enter>

" tidy selected lines (Perl-only)
" http://stackoverflow.com/questions/9202063
vnoremap <silent> <leader>t :!perltidy <C-r>=b:perltidy_options<Enter><Enter>

" write with sudo
" http://stackoverflow.com/questions/2600783
nnoremap <silent> <leader>w :w !sudo tee %<Enter>
