""" vim colorscheme - experiment by rubasov

""" rules for future change
"
" prefer setting foreground color only
" avoid bold
" avoid reverse
" use red for error only
" use yellow sparsely
" bright for important, faint for less important

""" see also
"
" :help highlight-groups
" :source $VIMRUNTIME/syntax/hitest.vim
" 256colors.pl - https://gist.github.com/1095100
" http://vimdoc.sourceforge.net/htmldoc/syntax.html#:highlight
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
" http://vim.wikia.com/wiki/Better_colors_for_syntax_highlighting
" http://doc.qt.nokia.com/qq/qq26-adaptivecoloring.html

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

set background=dark  " light / dark
let colors_name = "experiment"

""" color scheme explanation
""" in rough attention order
"
"     darkred bg     - error
"     yellow bg      - warning
" 208 orange         - identifiers and constants
"  76 green          - strings
"     white          - cover important rest (operators, calls, ...)
"  27 blue           - control structures
" 162 purple         - compile time and various stuff
" 220 yellow         - escapes
"     grey           - comments
" 236 dark grey      - visible tabs and trailing space
" 233 very dark grey - visual mode selection

"" name all colors of the palette

let s:darkred = "darkred"
let s:darkerred = 52

let s:gray = "gray"
let s:darkgray = "darkgray"
let s:darkergray = 236
let s:darkestgray = 233

let s:black = "black"
let s:blue = 27
let s:green = 76
let s:magenta = 162
let s:orange = 208
let s:white = "white"
let s:yellow = 220

"" requires immediate attention: focus, warnings, errors

exe "hi! CursorLineNR"    "cterm=none" "ctermbg=none" "ctermfg=".s:darkerred
exe "hi! Error"           "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! ErrorMsg"        "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! ExtraWhitespace" "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! MatchParen"      "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! SpellBad"        "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! WarningMsg"      "cterm=none" "ctermbg=none" "ctermfg=".s:darkred

"" requires awereness: searches, TODO, FIXME, XXX

exe "hi! IncSearch" "cterm=none" "ctermbg=none" "ctermfg=".s:yellow
exe "hi! Search"    "cterm=none" "ctermbg=none" "ctermfg=".s:yellow
exe "hi! Todo"      "cterm=none" "ctermbg=none" "ctermfg=".s:yellow

"" normal data

exe "hi! Constant"   "cterm=none" "ctermbg=none" "ctermfg=".s:orange
exe "hi! Directory"  "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Identifier" "cterm=none" "ctermbg=none" "ctermfg=".s:orange
exe "hi! Normal"     "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Operator"   "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! PreProc"    "cterm=none" "ctermbg=none" "ctermfg=".s:magenta
exe "hi! Question"   "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Statement"  "cterm=none" "ctermbg=none" "ctermfg=".s:blue
exe "hi! Title"      "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Type"       "cterm=none" "ctermbg=none" "ctermfg=".s:magenta

"" low attention data

exe "hi! Comment" "cterm=none" "ctermbg=none" "ctermfg=".s:gray
exe "hi! Special" "cterm=none" "ctermbg=none" "ctermfg=".s:yellow
exe "hi! String"  "cterm=none" "ctermbg=none" "ctermfg=".s:green

"" low attention foreground

exe "hi! LineNr"     "cterm=none" "ctermbg=none" "ctermfg=".s:darkergray
exe "hi! NonText"    "cterm=none" "ctermbg=none" "ctermfg=".s:darkergray
exe "hi! SpecialKey" "cterm=none" "ctermbg=none" "ctermfg=".s:darkergray

"" low attention background

exe "hi! ColorColumn"  "cterm=none" "ctermbg=".s:darkestgray
exe "hi! DiffChange"   "cterm=none" "ctermbg=".s:darkestgray
exe "hi! DiffDelete"   "cterm=none" "ctermbg=".s:black       "ctermfg=".s:darkestgray
exe "hi! DiffText"     "cterm=none" "ctermbg=".s:darkestgray
exe "hi! StatusLine"   "cterm=none" "ctermbg=".s:darkestgray "ctermfg=".s:white
exe "hi! StatusLineNC" "cterm=none" "ctermbg=".s:darkestgray "ctermfg=".s:gray
exe "hi! VertSplit"    "cterm=none" "ctermbg="."none"        "ctermfg=".s:darkestgray
exe "hi! Visual"       "cterm=none" "ctermbg=".s:darkestgray

"" kill the noise

exe "hi! CursorLine" "cterm=none"      "ctermbg="."none"
exe "hi! DiffAdd"    "cterm=none"      "ctermbg=".s:black
exe "hi! FoldColumn" "cterm=none"      "ctermbg=".s:darkgray "ctermfg=".s:black
exe "hi! Folded"     "cterm=none"      "ctermbg=".s:darkgray "ctermfg=".s:black
exe "hi! Underlined" "cterm=underline" "ctermbg="."none"     "ctermfg=none"

"" TODO

" Conceal
" CursorColumn
" FoldColumn
" Folded
" Pmenu
" PmenuSbar
" PmenuSel
" PmenuThumb
" SignColumn
" SpellCap
" SpellLocal
" SpellRare
" TabLine
" TabLineFill
" TabLineSel
" WildMenu

" http://blog.kamil.dworakowski.name
"     /2009/09/unobtrusive-highlighting-of-trailing.html
"
autocmd BufEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/
