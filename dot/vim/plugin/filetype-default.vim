" query currently recognized language
" http://stackoverflow.com/questions/5324971
"
" :set filetype?
" :set ft?

" defaults
for s:filetype in [ 
    \ "c",
    \ "clojure",
    \ "cpp",
    \ "dot",
    \ "gitcommit",
    \ "lisp",
    \ "make",
    \ "markdown",
    \ "mysql",
    \ "perl",
    \ "python",
    \ "sh",
    \ "sql",
    \ "vim"
    \ ]

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
