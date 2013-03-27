""" Anything that requires unicode / utf-8.
"
" You can enter unicode chars like: <C-v>uNNNN
" Where NNNN is the unicode code point.

set encoding=utf-8

" visible tabs, trailing whitespace
" u00b7: middle dot: ·
" u2022: bullet: •
let &listchars = "tab:\u2022\u00b7,trail:\u00b7,nbsp:\u00b7"

" :help 'fillchars'
" u2500: box drawing single horizontal line: ─
" u2502: box drawing single vertical line: │
let &fillchars = "diff:\u2500,vert:\u2502"
