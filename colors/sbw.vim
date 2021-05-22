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

function! s:create_color_alias(name, color, ...)
    let additionalOptions = get(a:, 1, 'gui=NONE')
    let {'s:fg_' . a:name} = ' guifg=' . a:color . ' ' . l:additionalOptions
    let {'s:bg_' . a:name} = ' guibg=' . a:color . ' ' . l:additionalOptions
    " exec 'echo "Created s:fg_' . a:name . ' as' . {'s:fg_' . a:name} . '"'
    " exec 'echo "Created s:bg_' . a:name . ' as' . {'s:bg_' . a:name} . '"'
endfun

call s:create_color_alias('title',                '#ffffff')
call s:create_color_alias('foreground',           '#bcbcbc')
call s:create_color_alias('background',           '#262626')
call s:create_color_alias('comment',              '#585858')
call s:create_color_alias('folded_foreground',    '#585858', 'gui=bold')
call s:create_color_alias('folded_background',    '#262626', 'gui=bold')
call s:create_color_alias('identifier',           '#5f87af')
call s:create_color_alias('function',             '#ffffaf')
call s:create_color_alias('statement',            '#8fafd7')
call s:create_color_alias('constant',             '#87af87')
call s:create_color_alias('preproc',              '#5f8787')
call s:create_color_alias('error',                '#af5f5f')
call s:create_color_alias('type',                 '#8787af')
call s:create_color_alias('selection_foreground', '#ffffff')
call s:create_color_alias('selection_background', '#585858')

call s:create_color_alias('diff_added',           '#87af87')
call s:create_color_alias('diff_removed',         '#af5f5f')
call s:create_color_alias('diff_changed',         '#8fafd7')

call s:create_color_alias('ui_marker_foreground', '#bcbcbc')
call s:create_color_alias('ui_marker_background', '#262626')
call s:create_color_alias('ui_menu_foreground',   '#bcbcbc')
call s:create_color_alias('ui_menu_background',   '#464646')
call s:create_color_alias('ui_border_foreground', '#bcbcbc')
call s:create_color_alias('ui_border_background', '#464646')

" ColorColumn   used for the columns set with 'colorcolumn'
" Conceal       placeholder characters substituted for concealed
" Cursor        character under the cursor
" CursorColumn  Screen-column at the cursor, when 'cursorcolumn' is set.
" CursorIM  like Cursor, but used when in IME mode |CursorIM|
" CursorLine    Screen-line at the cursor, when 'cursorline' is set.
" CursorLineNr  Like LineNr when 'cursorline' or 'relativenumber' is set for
" Directory directory names (and other special names in listings)
" EndOfBuffer   filler lines (~) after the end of the buffer.
" ErrorMsg  error messages on the command line
" FoldColumn    'foldcolumn'
" Folded        line used for closed folds
" IncSearch 'incsearch' highlighting; also used for the text replaced with
" LineNr        Line number for ":number" and ":#" commands, and when 'number'
" MatchParen    The character under the cursor or just before it, if it
" ModeMsg       'showmode' message (e.g., "-- INSERT --")
" MoreMsg       |more-prompt|
" MsgArea       Area for messages and cmdline
" MsgSeparator  Separator for scrolled messages, `msgsep` flag of 'display'
" NonText       '@' at the end of the window, characters from 'showbreak' 
" Normal        normal text
" NormalFloat   Normal text in floating windows.
" NormalNC  normal text in non-current windows
" Pmenu     Popup menu: normal item.
" PmenuSbar Popup menu: scrollbar.
" PmenuSel  Popup menu: selected item.
" PmenuThumb    Popup menu: Thumb of the scrollbar.
" Question  |hit-enter| prompt and yes/no questions
" QuickFixLine  Current |quickfix| item in the quickfix window. Combined with
" Search        Last search pattern highlighting (see 'hlsearch').
" SignColumn    column where |signs| are displayed
" SpecialKey    Unprintable characters: text displayed differently from what
" SpellBad  Word that is not recognized by the spellchecker. |spell|
" SpellCap  Word that should start with a capital. |spell|
" SpellLocal    Word that is recognized by the spellchecker as one that is
" SpellRare Word that is recognized by the spellchecker as one that is
" StatusLine    status line of current window
" StatusLineNC  status lines of not-current windows
" Substitute    |:substitute| replacement text highlighting
" TabLine       tab pages line, not active tab page label
" TabLineFill   tab pages line, where there are no labels
" TabLineSel    tab pages line, active tab page label
" TermCursor    cursor in a focused terminal
" TermCursorNC  cursor in an unfocused terminal
" Title     titles for output from ":set all", ":autocmd" etc.
" VertSplit the column separating vertically split windows
" Visual        Visual mode selection
" VisualNOS Visual mode selection when vim is "Not Owning the Selection".
" WarningMsg    warning messages
" Whitespace    "nbsp", "space", "tab" and "trail" in 'listchars'
" WildMenu  current match in 'wildmenu' completion


exec 'hi Comment'     . s:fg_comment              . s:bg_background
exec 'hi Constant'    . s:fg_constant             . s:bg_background
exec 'hi EndOfBuffer' . s:fg_comment              . s:bg_background
exec 'hi Error'       . s:fg_error                . s:bg_background
exec 'hi FoldColumn'  . s:fg_folded_foreground    . s:bg_folded_background
exec 'hi Folded'      . s:fg_folded_foreground    . s:bg_folded_background
exec 'hi Function'    . s:fg_function             . s:bg_background
exec 'hi Identifier'  . s:fg_identifier           . s:bg_background
exec 'hi Normal'      . s:fg_foreground           . s:bg_background
exec 'hi PreProc'     . s:fg_preproc              . s:bg_background
exec 'hi Search'      . s:fg_selection_foreground . s:bg_selection_background
exec 'hi Statement'   . s:fg_statement            . s:bg_background
exec 'hi Title'       . s:fg_title                . s:bg_background
exec 'hi Type'        . s:fg_type                 . s:bg_background

"exec 'hi VertSplit'    . s:fg_ui_menu_foreground   . s:bg_ui_menu_background
"exec 'hi StatusLine'   . s:fg_ui_border_foreground . s:bg_ui_border_background
"exec 'hi StatusLineNC' . s:fg_ui_border_foreground . s:bg_ui_border_background
"exec 'hi SignColumn'   . s:fg_ui_marker_foreground . s:bg_ui_marker_background
exec 'hi Pmenu'       . s:fg_ui_menu_foreground      . s:bg_ui_menu_background
exec 'hi PmenuSbar'   . s:fg_ui_menu_foreground      . s:bg_ui_menu_background
exec 'hi PmenuSel'    . s:fg_selection_foreground . s:bg_selection_background

exec 'hi DiffAdd'     . s:fg_selection_foreground . s:bg_diff_added
exec 'hi DiffChange'  . s:fg_selection_foreground . s:bg_diff_changed
exec 'hi DiffDelete'  . s:fg_selection_foreground . s:bg_diff_removed
exec 'hi DiffText'    . s:fg_selection_foreground . s:bg_diff_added

let colors_name = "sbw"

"https://github.com/morhetz/gruvbox/blob/master/colors/gruvbox.vim

"---- hi Special      guifg=#5f875f           guibg=bg                gui=NONE
"---- hi MatchParen   guifg=#5f875f           guibg=darkslategray     gui=bold
"---- hi Error        guifg=#af5f5f           guibg=bg                gui=NONE

" Links
hi! link Special    Constant
hi! link Todo       WarningMsg
hi! link IncSearch  Search
hi! link MatchParen Search
hi! link Visual     Search

" File explorer
hi! link Directory  Keyword





"---- hi! link CursorIM       Cursor
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
"---- hi FoldColumn   guifg=gray60            guibg=bg                gui=italic
"---- hi NonText      guifg=gray50            guibg=bg                gui=NONE
"---- hi SpecialKey   guifg=gray50            guibg=bg                gui=NONE
"---- hi StatusLine   guifg=gray100           guibg=PaleTurquoise4    gui=bold
"---- hi StatusLineNC guifg=fg                guibg=gray30            gui=NONE
"---- hi VisualNOS    guifg=fg                guibg=gray40            gui=NONE
