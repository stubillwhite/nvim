" vim:fdm=marker

"TODO: See https://github.com/morhetz/gruvbox/blob/master/colors/gruvbox.vim

" Theme setup                                                               {{{1
" ==============================================================================

let colors_name = "sbw-two"

set bg=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

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
call s:create_highlight('Selection', s:PaletteWhite, s:PaletteDarkGrey)
hi! link Visual     Selection
hi! link VisualNOS  Visual
hi! link Search     Selection
hi! link IncSearch  Search
hi! link MatchParen Search

" Gutter
hi! link LineNr     Comment
hi! link SignColumn Comment
hi! link Folded     Comment
hi! link FoldColumn Comment

" UI                                {{{2
" ======================================



"               " Correct background (see issue #7):
"               " --- Problem with changing between dark and light on 256 color terminal
"               " --- https://github.com/morhetz/gruvbox/issues/7
"               if s:is_dark
"                 set background=dark
"               else
"                 set background=light
"               endif
"               
"               if version >= 700
"                 " Screen line that the cursor is
"                 call s:HL('CursorLine',   s:none, s:bg1)
"                 " Screen column that the cursor is
"                 hi! link CursorColumn CursorLine
"               
"                 " Tab pages line filler
"                 call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
"                 " Active tab page label
"                 call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
"                 " Not active tab page label
"                 hi! link TabLine TabLineFill
"               
"               endif
"               
"               if version >= 703
"                 " Highlighted screen columns
"                 call s:HL('ColorColumn',  s:none, s:color_column)
"               
"                 " Concealed element: \lambda → λ
"                 call s:HL('Conceal', s:blue, s:none)
"               
"                 " Line number of CursorLine
"                 call s:HL('CursorLineNr', s:yellow, s:bg1)
"               endif
"               
"               hi! link NonText GruvboxBg2
"               hi! link SpecialKey GruvboxBg2
"               
"               call s:HL('Underlined', s:blue, s:none, s:underline)
"               
"               call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
"               call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)
"               
"               " The column separating vertically split windows
"               call s:HL('VertSplit', s:bg3, s:vert_split)
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
"               " Error messages on the command line
"               call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
"               " More prompt: -- More --
"               hi! link MoreMsg GruvboxYellowBold
"               " Current mode message: -- INSERT --
"               hi! link ModeMsg GruvboxYellowBold
"               " 'Press enter' prompt and yes/no questions
"               hi! link Question GruvboxOrangeBold
"               " Warning messages
"               hi! link WarningMsg GruvboxRedBold
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
call s:create_highlight('Statement',  s:PaletteLightBlue)
call s:create_highlight('Keyword',    s:PaletteLightBlue)
hi! link Conditional Keyword
hi! link Repeat      Keyword
hi! link Label       Keyword
hi! link Exception   Keyword
hi! link Operator    Keyword
hi! link Type        Keyword
hi! link Special     Normal
call s:create_highlight('Comment',    s:PaletteDarkGrey)

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
call s:create_highlight('Constant',   s:PaletteBlue)
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
