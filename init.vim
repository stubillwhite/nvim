" vim:fdm=marker

" Prerequisites                                                             {{{1
" ==============================================================================

let g:TmpDir='~/.config/nvim-tmp'

" Enable cursor shapes
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Set <Leader> to something easier to reach
let mapleader=","
let g:mapleader=","

" Plugins                                                                   {{{1
" ==============================================================================

" Master list of all plugins        {{{2
" ======================================

call plug#begin('~/.config/vim-plug')

" Appearance
Plug 'romainl/Apprentice'           " A dark, low-contrast, Vim colorscheme
Plug 'noah/vim256-color'            " A collection of 256-color colorschemes for Vim
Plug 'godlygeek/csapprox'           " Use GUI color schemes in terminals
Plug 'itchyny/lightline.vim'        " A light and configurable statusline plugin for Vim
Plug 'junegunn/seoul256.vim'

" Syntax and static checking
Plug 'w0rp/ale'                     " Asynchronous Lint Engine

" Languages
Plug 'ElmCast/elm-vim'              " Elm plugin for Vim
Plug 'derekwyatt/vim-scala'         " Scala
Plug 'davidhalter/jedi-vim'         " Smarter Python integration
Plug 'vim-scripts/applescript.vim'  " Applescript syntax highlighting
Plug 'tmux-plugins/vim-tmux'        " Syntax for tmux configuration
Plug 'othree/xml.vim'               " Helps editing XML files

" Interface
Plug 'Olical/vim-enmasse'           " Edit every line in a quickfix list at the same time
Plug 'Raimondi/delimitMate'         " Automatically close quotes, brackets, etc
Plug 'Valloric/YouCompleteMe'       " Smarter completion
Plug 'jaxbot/browserlink.vim'       " Live browser editing for Vim
Plug 'jlanzarotta/bufexplorer'      " Easy buffer browsing
Plug '/usr/local/opt/fzf'           " FZF installation
Plug 'junegunn/fzf.vim'             " FZF fuzzy finder for Vim
Plug 'mileszs/ack.vim'              " Vim plugin for the Perl module / CLI script 'ack'
Plug 'scrooloose/nerdcommenter'     " Easy multi-language commenting
Plug 'scrooloose/nerdtree'          " Easy file browsing
Plug 'simnalamburt/vim-mundo'       " Visualise the undo graph
Plug 'terryma/vim-expand-region'    " Incremental selection widening
Plug 'tpope/vim-endwise'            " Smart closing of data strutures
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'tpope/vim-repeat'             " Smarter repeat functionality
Plug 'tpope/vim-surround'           " quoting/parenthesizing made simple
Plug 'tpope/vim-unimpaired'         " Incredibly useful text navigation and manipulation shortcuts
Plug 'vimlab/split-term.vim'        " Utilities around neovim's terminal

Plug 'junegunn/vim-easy-align'      " A simple, easy-to-use Vim alignment plugin
Plug 'godlygeek/tabular'            " Vim script for text filtering and alignment

call plug#end()

" junegunn/vim-easy-align           {{{2
" ======================================
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)<Paste>

" Raimondi/delimitMate              {{{2
" ======================================
let delimitMate_expand_cr = 1

" scrooloose/nerdtree               {{{2
" ======================================
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>E :NERDTreeFind<CR>

" junegunn/fzf                      {{{2
" ======================================

set rtp+=/usr/local/opt/fzf

" itchny/lightline                  {{{2
" ======================================

" Lightline
let g:lightline = {
\ 'colorscheme': 'seoul256',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['percent'], ['lineinfo'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function LightlineLinterWarnings()
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✱', all_non_errors)
endfunction

function LightlineLinterErrors()
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✘', all_errors)
endfunction

function LightlineLinterOK()
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✔ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" simnalamburt/vim-mundo            {{{2
" ======================================
nnoremap <Leader>u :MundoToggle<CR>

" mileszs/ack.vim                   {{{2
" ======================================
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" w0rp/ale                          {{{2
" ======================================

" Use quickfix instead of loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" Functions                                                                 {{{1
" ==============================================================================

" General Vim functions             {{{2
" ======================================

" Set all the relevant tab options to the specified level
function s:TabStop(n)
    silent execute 'set tabstop='.a:n
    silent execute 'set shiftwidth='.a:n
    silent execute 'set softtabstop='.a:n
endfunction
command -nargs=1 TabStop call s:TabStop(<f-args>)

" Create the specified directory if it doesn't exist
function s:CreateDirectory(path)
   if !isdirectory(a:path)
      call mkdir(a:path, 'p')
  endif
endfunction

" Switch off diff mode for the current window
function s:NoDiffThis()
    silent execute 'diffoff | set nowrap'
endfunction
command -nargs=0 NoDiffThis call s:NoDiffThis(<f-args>)

" Format JSON
function s:FormatJson()
    silent execute '%! jq .'
endfunction
command -nargs=0 FormatJson call s:FormatJson(<f-args>)

function s:FormatJsonAndSort()
    silent execute '%! jq -S .'
endfunction
command -nargs=0 FormatJsonAndSort call s:FormatJsonAndSort(<f-args>)

" Format XML
function! s:FormatXML()
    silent execute '%! xmllint --format %'
endfunction
command -nargs=0 FormatXML call s:FormatXML(<f-args>)

" Text functions                    {{{2
" ======================================

" Convert fancy punctuation back into ASCII
function s:FixSmartPunctuation()
    silent! %s/\%u00B4/'/g
    silent! %s/\%u0091/'/g
    silent! %s/\%u0092/'/g
    silent! %s/\%u0093/"/g
    silent! %s/\%u0094/"/g
    silent! %s/\%u2014/--/g
    silent! %s/\%u2019/'/g
    silent! %s/\%u201C/"/g
    silent! %s/\%u201D/"/g
    silent! %s/\%u2026/.../g
endfunction
command -nargs=0 FixSmartPunctuation call s:FixSmartPunctuation(<f-args>)

" Remove ASCII color codes
function s:FixAsciiColorCodes()
    silent! %s/\e\[[0-9;]\+[mK]//g
endfunction
command -nargs=0 FixAsciiColorCodes call s:FixAsciiColorCodes(<f-args>)

" Strip trailing whitespace characters from the entire file or a range
function s:StripTrailingWhitespace() range
    let l:save_search=@/
    let l:save_cursor = getpos('.')
    silent execute a:firstline.','a:lastline.'s/\s\+$//e'
    let @/=l:save_search
    silent call setpos('.', l:save_cursor)
endfunction
command -range=% StripTrailingWhitespace <line1>,<line2> call s:StripTrailingWhitespace()

" Key bindings                                                              {{{1
" ==============================================================================

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme apprentice
set background=dark

" Settings                                                                  {{{1
" ==============================================================================

" General settings
set backup                                  " Use backup files
set hidden                                  " Keep buffers open when not displayed
set ruler                                   " Show the file position
set copyindent                              " Copy indentation characters
set showcmd                                 " Show incomplete commands
set noshowmode                              " Don't show the active mode, mirrored in lightline
set incsearch                               " Search incrementally
set hlsearch                                " Search highlighting
set history=1000                            " Keep more history
set visualbell                              " No beep
set expandtab                               " No tabs
set nowrap                                  " No wrapping text
set nojoinspaces                            " Single-space when joining sentences
set title                                   " Set the title of the terminal
set ignorecase                              " Case insensitive by default...
set smartcase                               " ...but case sensitive if term includes uppercase
set scrolloff=2                             " Keep some context when scrolling vertically
set sidescrolloff=2                         " Keep some context when scrolling horizontally
set nostartofline                           " Keep horizontal cursor position when scrolling
set formatoptions+=n                        " Format respects numbered/bulleted lists
set iskeyword+=-                            " Dash is part of a word for movement purposes
set virtualedit=                            " No virtual edit
set timeoutlen=500                          " Timeout to press a key combination
set report=0                                " Always report changes
set undofile                                " Allow undo history to persist between sessions
set path=.,,.\dependencies\**               " Search path
set tags=./tags,../../tags                  " Default tags files
set listchars=tab:>-,eol:$                  " Unprintable characters to display
set laststatus=2                            " Always have a statusline
TabStop 4                                   " Default to 4 spaces per tabstop

syntax on                                   " Syntax highlighting

" Enable extended character sets
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set guifontwide=NSimsun:h10

" Command / file completion
set noshellslash                            " Backslashes for filenames for ZIP plugin
set wildmenu                                " Display options when tab completing
set wildmode=list:longest,full              " List options but complete to full
set wildignore=
set wildignore+=*.class,*.obj,*.pyc
set wildignore+=*/.hg/*,*/.git/*,*/.svn/*
set wildignore+=*/bld/*,*/bin/*

" Misc options
let g:netrw_altv=1                          " Netrw vertical split puts cursor on the right

" Standard plugin to allow % to match keywords as well as braces
runtime macros/matchit.vim

" Store Undo/Backup/Swap files in a temporary directory
silent execute 'set undodir='.g:TmpDir.'/undo'
silent execute 'set backupdir='.g:TmpDir.'/backup'
silent execute 'set directory='.g:TmpDir.'/swap'
call s:CreateDirectory(&undodir)
call s:CreateDirectory(&backupdir)
call s:CreateDirectory(&directory)

" Error and make files
set shellpipe=2>&1\ \|\ tee
silent execute 'set errorfile='.g:TmpDir.'/error_file.txt'
silent execute 'set makeef='.g:TmpDir.'/make_error_file.txt'

" Autocmds
augroup VimrcEditingAutocommands

    " When editing a file, always jump to the last known cursor position
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " Normalise splits when resizing
    au VimResized * exe "normal! \<C-w>="

    " Syntax highlight from the start for better accuracy
    au BufEnter * :syntax sync fromstart

augroup END

" File comparison options
set diffopt=filler,iwhite
if has('unix')
    set diffexpr=
else
    set diffexpr=MyDiff()
    function MyDiff()
      let opt = ''
      if &diffopt =~ 'icase'  | let opt = opt.'-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt.'-b ' | endif
      silent execute '!"'.$VIMRUNTIME.'/diff.exe" -r '.opt.v:fname_in.' '.v:fname_new.' > '.v:fname_out
    endfunction
endif

" Special configuration for a diff window
function ConfigureGui()
    if &diff
        silent execute 'MaximiseWindow'
        let cmd = 'set titlestring=Diff\ (' . expand("%:t") . ')'
        silent execute cmd
    endif
endfunction
autocmd GUIEnter * call ConfigureGui()


" Search                                                                    {{{1
" ==============================================================================

function s:SearchInteractive()
    let SearchCmd=':Ack '.a:wrd
    call feedkeys(SearchCmd."\<HOME>\<RIGHT>\<RIGHT>\<RIGHT>\<RIGHT>\<RIGHT>\<RIGHT>\<RIGHT>\<RIGHT>\<RIGHT>")
endfunction
command -nargs=0 SearchInteractive call s:SearchInteractive(<f-args>)

function s:SearchImmediate(wrd)
    let SearchCmd=':Ack '.a:wrd
    call feedkeys(SearchCmd)
    call feedkeys("\<CR>")
endfunction
command -nargs=1 SearchImmediate call s:SearchImmediate(<f-args>)

" File types                                                                {{{1
" ==============================================================================

augroup VimrcFileTypeAutocommands
    au BufRead,BufNewFile *.md                          setlocal filetype=markdown
    au BufRead,BufNewFile *.log                         setlocal filetype=log
    au BufRead,BufNewFile *.applescript                 setlocal filetype=applescript
    au BufRead,BufNewFile *.boot                        setlocal filetype=clojure
augroup END

" Key mappings                                                              {{{1
" ==============================================================================

" <Space> in normal mode removes highlighted search
nnoremap <Space> :nohlsearch<Return>:echo "Search highlight off"<Return>

" Use semi-colon as an alias for colon for easier access to Ex commands. Unmap
" colon to force your fingers to use it.
nnoremap ; :
vnoremap ; :

" Swap ` and ' because ` functionality is more useful but the key is hard to reach
nnoremap ' `
nnoremap ` '

" Navigate wrapped lines more easily
nnoremap j gj
nnoremap k gk

" Quick way to edit .vimrc
nmap <Leader>v :e ~/.config/nvim/init.vim<CR><CR>

" Copy-all to clipboard and paste-all from clipboard
nnoremap <Leader>ac :%y+<CR>
nnoremap <Leader>ap :%d_<CR>"+pk"_dd

" Fast window navigation
map <S-LEFT> <C-w>h
map <S-DOWN> <C-w>j
map <S-UP> <C-w>k
map <S-RIGHT> <C-w>l

" Use standard regexes for search, not Vim regexes
nnoremap / /\v
vnoremap / /\v

" Grep for the word currently under the cursor
" CTRL-G immediate, ALT-G interactive
nnoremap <C-G> :SearchImmediate <C-R><C-W><CR>
nnoremap ç     :SearchInteractive <CR>

" Show unprintable characters
nmap <Leader>w :set list!<CR>

" Strip trailing whitespace characters
nnoremap <silent> <Leader>W :StripTrailingWhitespace<CR>
vnoremap <silent> <Leader>W :StripTrailingWhitespace<CR>

" Map insert mode and command-line mode CTRL-Backspace to delete the previous word
imap <C-BS> <C-W>
cmap <C-BS> <C-W>


"let g:seoul256_background = 235
"colo seoul256


" VimTip #171 -- Search for visually selected text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" BufExplorer
nmap <Leader>b :BufExplorer<CR>
let g:bufExplorerSortBy='name'      " Default sort by the name

" Align commas in paragraph: gaip*,
