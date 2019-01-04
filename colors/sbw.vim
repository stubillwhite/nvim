" FILE: white.vim
"
" DESCRIPTION: 
" Reverse-video colour settings; only suitable for the GUI.
"
"
" TODO: THIS LOOKS RELEVANT
" https://github.com/nlknguyen/papercolor-theme/blob/master/colors/papercolor.vim
" https://raw.githubusercontent.com/NLKNguyen/papercolor-theme/master/colors/PaperColor.vim

set bg=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

" :syn list

" Pallette 
" Dark     #262626
" medium grey     #585858    rgb(88, 88, 88)       240    8
" lighter grey    #bcbcbc    rgb(188, 188, 188)    250    foreground color
" green           #5f875f    rgb(95, 135, 95)      65     2
" blue            #5f87af    rgb(95, 135, 175)     67     4
" red             #af5f5f    rgb(175, 95, 95)      131    1

let colors_name = "sbw"

hi Normal       guifg=#bcbcbc           guibg=#262626           gui=NONE

hi Comment      guifg=#585858           guibg=bg                gui=NONE
hi Constant     guifg=#5f875f           guibg=bg                gui=NONE
hi Identifier   guifg=#bcbcbc           guibg=bg                gui=NONE
hi Statement    guifg=#8fafd7           guibg=bg                gui=NONE
hi PreProc      guifg=#af5f5f           guibg=bg                gui=NONE
hi Type         guifg=#bcbcbc           guibg=bg                gui=NONE
hi Special      guifg=#5f875f           guibg=bg                gui=NONE
hi MatchParen   guifg=#5f875f           guibg=darkslategray     gui=bold
"hi Underlined
"hi Ignore
hi Error        guifg=#af5f5f           guibg=bg                gui=NONE


" Links
hi! link CursorIM       Cursor
hi! link VertSplit      StatusLineNC
hi! link Pmenu          StatusLineNC
hi! link IncSearch      Search 
hi! link LineNr         ErrorMsg
hi! link ModeMsg        ErrorMsg
hi! link MoreMsg        ErrorMsg
hi! link Question       ErrorMsg
hi! link WarningMsg     ErrorMsg
hi! link shDerefSimple  Keyword
hi! link Todo           ErrorMsg
hi! link Title          ErrorMsg
hi! link SpellCap       ErrorMsg
hi! link WildMenu       Visual
hi! link Directory      Keyword

" highlight-groups
hi Cursor       guifg=bg                guibg=fg                gui=NONE

hi DiffAdd      guifg=fg                guibg=aquamarine4       gui=NONE
hi DiffChange   guifg=fg                guibg=royalblue4        gui=NONE
hi DiffDelete   guifg=fg                guibg=indianred4        gui=NONE
hi DiffText     guifg=fg                guibg=royalblue3        gui=NONE

hi ErrorMsg     guifg=#bcbcbc           guibg=bg                gui=bold,undercurl  guisp=#af5f5f
hi Folded       guifg=gray60            guibg=gray15            gui=italic
hi FoldColumn   guifg=gray60            guibg=bg                gui=italic
hi NonText      guifg=gray50            guibg=bg                gui=NONE
hi SpecialKey   guifg=gray50            guibg=bg                gui=NONE
hi Search       guifg=gray100           guibg=darkslategray     gui=NONE
hi StatusLine   guifg=gray100           guibg=PaleTurquoise4    gui=bold
hi StatusLineNC guifg=fg                guibg=gray30            gui=NONE
hi Visual       guifg=fg                guibg=gray40            gui=NONE
hi VisualNOS    guifg=fg                guibg=gray40            gui=NONE
