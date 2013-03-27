""" vim colorscheme - experiment by rubasov

""" designed for
"
" 256-color terminal (will be unusable with 16 colors)
" black background

"" was tested
"
" on tft monitors
" in pretty dark room / well-lit office
" on Perl, sh, C, vimscript source files

""" rules for future change
"
" prefer setting foreground color only
" avoid bold
" avoid reverse
" use red for error only
" use yellow sparsely
" bright for important, faint for less important

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

""" testing notes
"
" :vsplit
" :split
" :set number
" open a few source files
" :colorscheme experiment
" :help highlight-groups
" :source $VIMRUNTIME/syntax/hitest.vim
" try:
"     search highlight
"     incremental search highlight
"     warning/error messages

""" color-chooser.sh
"
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

""" see also
"
" 256colors.pl - https://gist.github.com/1095100
" http://vimdoc.sourceforge.net/htmldoc/syntax.html#:highlight
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
" http://vim.wikia.com/wiki/Better_colors_for_syntax_highlighting
" http://doc.qt.nokia.com/qq/qq26-adaptivecoloring.html

""" credits
"
" Bence Romsics <rubasov@gmail.com> 2012

set background=dark
highlight clear

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let colors_name = "experiment"

" test by :set colorcolumn
hi ColorColumn  cterm=none ctermbg=233
hi Comment      cterm=none ctermfg=grey
hi Constant     cterm=none ctermfg=208
hi CursorLine   cterm=none ctermbg=none
hi CursorLineNR cterm=none ctermfg=52
hi Identifier   cterm=none ctermfg=208
hi IncSearch    cterm=none ctermbg=220

" test by :set number
hi LineNr      cterm=none ctermfg=236

" tildes after end of file
hi NonText     cterm=none ctermfg=grey
hi MatchParen  cterm=underline ctermbg=none
hi Normal      cterm=none ctermfg=white
hi Operator    cterm=none ctermfg=white
hi PreProc     cterm=none ctermfg=162
hi Question    cterm=none ctermfg=darkred
hi Search      cterm=none ctermbg=220

" escape sequences in strings
hi Special     cterm=none ctermfg=220

" visible tabs, trailing spaces, binary junk, test by :set list
hi SpecialKey   cterm=none ctermfg=236
hi Statement    cterm=none ctermfg=27
hi StatusLine   cterm=none ctermbg=233 ctermfg=white
hi StatusLineNC cterm=none ctermbg=233 ctermfg=grey
hi String       cterm=none ctermfg=76
hi Todo         cterm=underline ctermbg=black ctermfg=220
hi Type         cterm=none ctermfg=162
hi VertSplit    cterm=none ctermfg=233
hi Visual       cterm=none ctermbg=233

" search hit BOTTOM, continuing at TOP
hi WarningMsg  cterm=none ctermfg=darkred

" colors for vimdiff
hi DiffAdd    cterm=none ctermbg=black
hi DiffDelete cterm=none ctermbg=black ctermfg=233
hi DiffChange cterm=none ctermbg=233
hi DiffText   cterm=none ctermbg=233
hi Folded     cterm=none ctermbg=darkgrey ctermfg=black
hi FoldColumn cterm=none ctermbg=darkgrey ctermfg=black
