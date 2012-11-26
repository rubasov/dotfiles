" vim color file
"
" tested with
"     256-color xterm
"     black background
"     Perl, sh, C, vim script
"     tft monitor
"     pretty dark room & well-lit room
"
" testing
"     :vsplit
"     :split
"     :set number
"     open a few source files
"     :colorscheme experiment
"     :source $VIMRUNTIME/syntax/hitest.vim
"     test: search, inc search, warning/error msg, etc
"
" look for colors in the list
" for i in 38 48
" do
"     for j in 5
"     do
"         for k in $( seq 16 231 ) $( seq 232 255 )
"         do
"             echo -e "\x1b[${i};${j};${k}m $i $j $k foobar \x1b[0m"
"         done
"     done
" done
"
" see also
"     256colors.pl - https://gist.github.com/1095100
"     http://vimdoc.sourceforge.net/htmldoc/syntax.html#:highlight
"     http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"     http://vim.wikia.com/wiki/Better_colors_for_syntax_highlighting
"     http://doc.qt.nokia.com/qq/qq26-adaptivecoloring.html
"
" todo
"     graceful degradation to 16 colors? seems impossible
"
" credits
"     Bence Romsics <rubasov@gmail.com> 2012

set background=dark
highlight clear

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let colors_name = "experiment"

" color scheme explanation (rough attention order)
"     darkred bg     - error
"     yellow bg      - warning
" 208 orange         - identifiers and constants
"  76 green          - strings
"     white          - cover important rest (operators, calls, ...)
"  27 blue           - control structures
" 162 purple         - compile time and various stuff
" 220 yellow         - escapes
"     grey           - comments
" 235 dark grey      - visible tabs and trailing space
" 234 very dark grey - visual mode selection

" rules for future change
"     prefer setting foreground color only
"     avoid bold
"     avoid reverse
"     use red for error only
"     use yellow sparsely
"     bright for important, faint for unimportant

hi Comment    cterm=none ctermfg=grey
hi Constant   cterm=none ctermfg=208
hi Identifier cterm=none ctermfg=208
hi IncSearch  cterm=none ctermbg=220
hi LineNr     cterm=none ctermfg=grey    " set number
hi NonText    cterm=none ctermfg=grey    " tildes after EOF
hi Normal     cterm=none ctermfg=white
hi Operator   cterm=none ctermfg=white
hi PreProc    cterm=none ctermfg=162
hi Question   cterm=none ctermfg=darkred " Press ENTER or type command to continue
hi Search     cterm=none ctermbg=220
hi Special    cterm=none ctermfg=220     " escape sequences in strings
hi SpecialKey cterm=none ctermfg=235     " visible tabs, trailing spaces, binary junk
hi Statement  cterm=none ctermfg=27
hi String     cterm=none ctermfg=76
hi Todo       cterm=none ctermbg=220     " TODO FIXME
hi Type       cterm=none ctermfg=162
hi Visual     cterm=none ctermbg=234
hi WarningMsg cterm=none ctermfg=darkred " search hit BOTTOM, continuing at TOP

" additional colors for vimdiff
" FIXME 2012-06-13 rubasov: DiffAdd-Todo clash (both tries to set ctermbg)
hi DiffAdd    cterm=none ctermbg=234
hi DiffDelete cterm=none ctermbg=234 ctermfg=232
hi DiffChange cterm=none ctermbg=234
hi DiffText   cterm=none ctermbg=232
hi Folded     cterm=none ctermbg=darkgrey ctermfg=black
hi FoldColumn cterm=none ctermbg=darkgrey ctermfg=black
