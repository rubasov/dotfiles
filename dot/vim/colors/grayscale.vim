""" grayscale - vim colorscheme by rubasov

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

set background=dark  " light / dark
let colors_name = "grayscale"

"" name all colors of the palette

let s:darkred = "darkred"
let s:darkerred = 52

let s:gray = "gray"
let s:darkgray = "darkgray"
let s:darkergray = 236
let s:darkestgray = 233

let s:white = "white"
let s:black = "black"
let s:orange = 208

"" requires immediate attention: focus, warnings, errors

exe "hi! CursorLineNR"    "cterm=none" "ctermbg=none" "ctermfg=".s:darkerred
exe "hi! Error"           "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! ErrorMsg"        "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! ExtraWhitespace" "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! MatchParen"      "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! SpellBad"        "cterm=none" "ctermbg=none" "ctermfg=".s:darkred
exe "hi! WarningMsg"      "cterm=none" "ctermbg=none" "ctermfg=".s:darkred

"" requires awereness: searches, TODO, FIXME, XXX

exe "hi! IncSearch" "cterm=none" "ctermbg=none" "ctermfg=".s:orange
exe "hi! Search"    "cterm=none" "ctermbg=none" "ctermfg=".s:orange
exe "hi! Todo"      "cterm=none" "ctermbg=none" "ctermfg=".s:orange

"" normal data

exe "hi! Constant"   "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Directory"  "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Identifier" "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Normal"     "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Operator"   "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! PreProc"    "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Question"   "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Statement"  "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Title"      "cterm=none" "ctermbg=none" "ctermfg=".s:white
exe "hi! Type"       "cterm=none" "ctermbg=none" "ctermfg=".s:white

"" low attention data

exe "hi! Comment" "cterm=none" "ctermbg=none" "ctermfg=".s:gray
exe "hi! Special" "cterm=none" "ctermbg=none" "ctermfg=".s:gray
exe "hi! String"  "cterm=none" "ctermbg=none" "ctermfg=".s:gray

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
