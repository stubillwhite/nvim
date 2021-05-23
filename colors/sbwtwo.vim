" vim:fdm=marker

" TODO: See https://github.com/morhetz/gruvbox/blob/master/colors/gruvbox.vim

" Theme setup                                                               {{{1
" ==============================================================================

set bg=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "sbwtwo"

" Functions                                                                 {{{1
" ==============================================================================

function! DisplaySynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call DisplaySynStack()<CR>

function! s:create_palette_alias(name, color)
    let {'s:Palette' . a:name} = a:color
    " exec 'echo "Created s:Palette' . a:name . ' as ' . {'s:Palette' . a:name} . '"'
endfun

function! s:create_highlight(group, fg, ...)
    " Argument order: group, fg, bg, gui
    let bg = get(a:, 1, 'NONE')
    let gui = get(a:, 2, 'NONE')

    exec join(['hi', 'clear', a:group], ' ')
    exec join(['hi', a:group, 'guifg=' . a:fg, 'guibg=' . l:bg, 'gui=' . l:gui], ' ')
endfun

" Palette                                                                   {{{1
" ==============================================================================

call s:create_palette_alias('White',        '#ffffff')
call s:create_palette_alias('LightGrey',    '#bcbcbc')
call s:create_palette_alias('DarkGrey',     '#585858')
call s:create_palette_alias('VeryDarkGrey', '#464646')
call s:create_palette_alias('LightBlack',   '#262626')
call s:create_palette_alias('Blue',         '#5f87af')
call s:create_palette_alias('Green',        '#87af87')
call s:create_palette_alias('Yellow',       '#ffffaf')
call s:create_palette_alias('LightBlue',    '#8fafd7')
call s:create_palette_alias('BlueGreen',    '#5f8787')
call s:create_palette_alias('Red',          '#af5f5f')
call s:create_palette_alias('Purple',       '#8787af')

" Highlight groups                                                          {{{1
" ==============================================================================

" Global                            {{{2
" ======================================

" Normal text
call s:create_highlight('Normal', s:PaletteLightGrey, s:PaletteLightBlack)

" Selection
call s:create_highlight('Selection', s:PaletteWhite, s:PaletteVeryDarkGrey)
hi! link Visual      Selection
hi! link VisualNOS   Visual
hi! link Search      Selection
hi! link IncSearch   Search
hi! link MatchParen  Search
hi! link CursorLine  Search
hi! link ColorColumn Search

" Gutter
hi! link LineNr      Comment
hi! link SignColumn  Comment
hi! link Folded      Comment
hi! link FoldColumn  Comment
hi! link EndOfBuffer Comment

" Splitter
hi! link VertSplit   Comment

" General messages
call s:create_highlight('ErrorMsg', s:PaletteRed)
call s:create_highlight('MoreMsg', s:PaletteLightBlue)
call s:create_highlight('ModeMsg', s:PaletteLightBlue)
hi! link Question Normal
call s:create_highlight('WarningMsg', s:PaletteYellow)

" UI                                {{{2
" ======================================

"                 " Tab pages line filler
"                 call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
"                 " Active tab page label
"                 call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
"                 " Not active tab page label
"                 hi! link TabLine TabLineFill
"               
"                 " Concealed element: \lambda → λ
"                 call s:HL('Conceal', s:blue, s:none)
"               
"                 " Line number of CursorLine
"                 call s:HL('CursorLineNr', s:yellow, s:bg1)
"              
"               hi! link NonText GruvboxBg2
"               hi! link SpecialKey GruvboxBg2
"               
"               call s:HL('Underlined', s:blue, s:none, s:underline)
"               
"               call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
"               call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)
"               
"               " Current match in wildmenu completion
"               call s:HL('WildMenu', s:blue, s:bg2, s:bold)
"               
"               " Directory names, special names in listing
"               hi! link Directory GruvboxGreenBold
"               
"               " Titles for output from :set all, :autocmd, etc.
"               hi! link Title GruvboxGreenBold
"               
"               
"               " }}}
"               
"               " }}}
"               " Cursor: {{{
"               
"               " Character under cursor
"               call s:HL('Cursor', s:none, s:none, s:inverse)
"               " Visual mode cursor, selection
"               hi! link vCursor Cursor
"               " Input moder cursor
"               hi! link iCursor Cursor
"               " Language mapping cursor
"               hi! link lCursor Cursor

" Menu
call s:create_highlight('Pmenu',     s:PaletteLightGrey, s:PaletteVeryDarkGrey)
call s:create_highlight('PmenuSbar', s:PaletteLightGrey, s:PaletteVeryDarkGrey)
hi! link PmenuSel Selection
"call s:create_highlight('PmenuThumb', s:none, s:bg4)

" Basic syntax                      {{{2
" ======================================

" Basic statements and keywords
call s:create_highlight('Statement', s:PaletteLightBlue)
call s:create_highlight('Keyword',   s:PaletteLightBlue)
hi! link Conditional Keyword
hi! link Repeat      Keyword
hi! link Label       Keyword
hi! link Exception   Keyword
hi! link Operator    Keyword
hi! link Type        Keyword
hi! link Special     Normal
call s:create_highlight('Comment',   s:PaletteDarkGrey)
call s:create_highlight('Todo',      s:PaletteYellow)
call s:create_highlight('Error',     s:PaletteRed)

" Identifiers
call s:create_highlight('Function',   s:PaletteYellow)
call s:create_highlight('Identifier', s:PaletteBlue)
hi! link Variable Identifier

" Preprocessor and macro
call s:create_highlight('PreProc',   s:PaletteBlueGreen)
hi! link Include   PreProc
hi! link Define    PreProc
hi! link Macro     PreProc
hi! link PreCondit PreProc

" Generic constant
call s:create_highlight('Constant',   s:PaletteBlueGreen)
hi! link Character Constant
hi! link Boolean   Constant
hi! link Number    Constant
hi! link Float     Constant

" Diff                              {{{2
" ======================================

call s:create_highlight('DiffDelete', s:PaletteWhite, s:PaletteRed)
call s:create_highlight('DiffAdd',    s:PaletteWhite, s:PaletteGreen)
call s:create_highlight('DiffChange', s:PaletteWhite, s:PaletteBlue)
call s:create_highlight('DiffText',   s:PaletteWhite, s:PaletteBlueGreen)

" Plugins                                                                   {{{1
" ==============================================================================

" NERDTree                          {{{2
" ======================================

hi! link NERDTreeDir       Keyword
hi! link NERDTreeDirSlash  NERDTreeDir
hi! link NERDTreeOpenable  NERDTreeDir
hi! link NERDTreeClosable  NERDTreeDir

hi! link NERDTreeFile      Normal
hi! link NERDTreeExecFile  ErrorMsg 

hi! link NERDTreeUp        NERDTreeDir
hi! link NERDTreeCWD       NERDTreeDir
hi! link NERDTreeHelp      Normal
hi! link NERDTreeToggleOn  Normal
hi! link NERDTreeToggleOff Normal
