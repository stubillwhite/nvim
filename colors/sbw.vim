" TODO: THIS LOOKS RELEVANT
" https://github.com/nlknguyen/papercolor-theme/blob/master/colors/papercolor.vim
" https://raw.githubusercontent.com/NLKNguyen/papercolor-theme/master/colors/PaperColor.vim

set bg=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

function! DisplaySynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call DisplaySynStack()<CR>

function! s:create_color_alias(name, color)
  let {'s:fg_' . a:name} = ' guifg=' . a:color . ' gui=NONE'
  let {'s:bg_' . a:name} = ' guibg=' . a:color . ' gui=NONE'
endfun

call s:create_color_alias('title',                '#ffffff')
call s:create_color_alias('foreground',           '#bcbcbc')
call s:create_color_alias('background',           '#262626')
call s:create_color_alias('comment',              '#585858')
call s:create_color_alias('identifier',           '#5f87af')
call s:create_color_alias('function',             '#ffffaf')
call s:create_color_alias('statement',            '#8fafd7')
call s:create_color_alias('constant',             '#87af87')
call s:create_color_alias('preproc',              '#5f8787')
call s:create_color_alias('error',                '#af5f5f')
call s:create_color_alias('type',                 '#8787af')
call s:create_color_alias('selection_foreground', '#ffffff')
call s:create_color_alias('selection_background', '#585858')

exec 'hi Title'      . s:fg_title                . s:bg_background
exec 'hi Normal'     . s:fg_foreground           . s:bg_background
exec 'hi Comment'    . s:fg_comment              . s:bg_background
exec 'hi Identifier' . s:fg_identifier           . s:bg_background
exec 'hi Function'   . s:fg_function             . s:bg_background
exec 'hi Statement'  . s:fg_statement            . s:bg_background
exec 'hi Constant'   . s:fg_constant             . s:bg_background
exec 'hi PreProc'    . s:fg_preproc              . s:bg_background
exec 'hi Error'      . s:fg_error                . s:bg_background
exec 'hi Type'       . s:fg_type                 . s:bg_background
exec 'hi Search'     . s:fg_selection_foreground . s:bg_selection_background

" :syn list

" Pallette 
" Dark     #262626
" medium grey     #585858    rgb(88, 88, 88)       240    8
" lighter grey    #bcbcbc    rgb(188, 188, 188)    250    foreground color
" green           #5f875f    rgb(95, 135, 95)      65     2
" blue            #5f87af    rgb(95, 135, 175)     67     4
" red             #af5f5f    rgb(175, 95, 95)      131    1

let colors_name = "sbw"

"---- hi Special      guifg=#5f875f           guibg=bg                gui=NONE
"---- hi MatchParen   guifg=#5f875f           guibg=darkslategray     gui=bold
"---- hi Error        guifg=#af5f5f           guibg=bg                gui=NONE

" Links
hi! link Special   Constant
hi! link Todo      WarningMsg
hi! link IncSearch Search

"---- hi! link CursorIM       Cursor
"---- hi! link VertSplit      StatusLineNC
"---- hi! link Pmenu          StatusLineNC
"---- hi! link LineNr         ErrorMsg
"---- hi! link ModeMsg        ErrorMsg
"---- hi! link MoreMsg        ErrorMsg
"---- hi! link Question       ErrorMsg
"---- hi! link WarningMsg     ErrorMsg
"---- hi! link shDerefSimple  Keyword
"---- hi! link Title          ErrorMsg
"---- hi! link SpellCap       ErrorMsg
"---- hi! link WildMenu       Visual
"---- hi! link Directory      Keyword
"---- 
"---- " highlight-groups
"---- hi Cursor       guifg=bg                guibg=fg                gui=NONE
"---- 
"---- hi DiffAdd      guifg=fg                guibg=aquamarine4       gui=NONE
"---- hi DiffChange   guifg=fg                guibg=royalblue4        gui=NONE
"---- hi DiffDelete   guifg=fg                guibg=indianred4        gui=NONE
"---- hi DiffText     guifg=fg                guibg=royalblue3        gui=NONE
"---- 
"---- hi ErrorMsg     guifg=#bcbcbc           guibg=bg                gui=bold,undercurl  guisp=#af5f5f
"---- hi Folded       guifg=gray60            guibg=gray15            gui=italic
"---- hi FoldColumn   guifg=gray60            guibg=bg                gui=italic
"---- hi NonText      guifg=gray50            guibg=bg                gui=NONE
"---- hi SpecialKey   guifg=gray50            guibg=bg                gui=NONE
"---- hi Search       guifg=gray100           guibg=darkslategray     gui=NONE
"---- hi StatusLine   guifg=gray100           guibg=PaleTurquoise4    gui=bold
"---- hi StatusLineNC guifg=fg                guibg=gray30            gui=NONE
"---- hi Visual       guifg=fg                guibg=gray40            gui=NONE
"---- hi VisualNOS    guifg=fg                guibg=gray40            gui=NONE
