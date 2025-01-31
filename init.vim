" vim:fdm=marker

" Prerequisites                                                             {{{1
" ==============================================================================

let g:TmpDir='~/.config/nvim-tmp'

" Set <Leader> to something easier to reach
let mapleader=","
let g:mapleader=","

" Python
let g:python3_host_prog = '~/dev/my-stuff/nvim/python-nvim/.venv/bin/python'


" Plugins                                                                   {{{1
" ==============================================================================

" Built-in plugins                  {{{2
" ======================================

packadd cfilter                     " Filter quickfix or location list

" Master list of all plugins        {{{2
" ======================================

call plug#begin('~/.config/vim-plug')

" Libraries
Plug 'nvim-lua/plenary.nvim'        " Async library required by other plugins

" Experimental
Plug 'sindrets/diffview.nvim'
" lua << EOF
" local actions = require("diffview.actions")
" require("diffview").setup({
"   use_icons = false         -- No nvim-web-devicons
" })
" EOF


Plug 'neomake/neomake'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


" Appearance
Plug 'romainl/Apprentice'           " A dark, low-contrast, Vim colorscheme
Plug 'noah/vim256-color'            " A collection of 256-color colorschemes for Vim
Plug 'itchyny/lightline.vim'        " A light and configurable statusline plugin for Vim
Plug 'junegunn/seoul256.vim'

Plug 'rebelot/kanagawa.nvim'        " TODO: Testing theme
Plug 'EdenEast/nightfox.nvim'       " TODO: Testing theme

" Syntax and static checking
Plug 'w0rp/ale'                     " Asynchronous Lint Engine
Plug 'neovim/nvim-lspconfig'        " Quickstart configs for Nvim LSP

" Languages
Plug 'ElmCast/elm-vim'              " Elm plugin for Vim
Plug 'derekwyatt/vim-scala'         " Scala
Plug 'udalov/kotlin-vim'            " Kotlin
Plug 'davidhalter/jedi-vim'         " Smarter Python integration
Plug 'vim-scripts/applescript.vim'  " Applescript syntax highlighting
Plug 'tmux-plugins/vim-tmux'        " Syntax for tmux configuration
Plug 'othree/xml.vim'               " Helps editing XML files
Plug 'pearofducks/ansible-vim'      " Ansible YAML files
Plug 'jvirtanen/vim-hcl'            " HashiCorp Configuration Language syntax highlighting
Plug 'aliou/bats.vim'               " BATS script testing language
Plug 'hashivim/vim-terraform'       " Basic vim/terraform integration

" Interface
Plug 'Olical/vim-enmasse'           " Edit every line in a quickfix list at the same time
Plug 'mg979/vim-visual-multi'       " Multiple cursor mode
Plug 'Raimondi/delimitMate'         " Automatically close quotes, brackets, etc
Plug 'Valloric/YouCompleteMe'       " Smarter completion
"Plug 'neoclide/coc.nvim', {'branch': 'release'} " TODO: CHECK THIS OUT
Plug 'jaxbot/browserlink.vim'       " Live browser editing for Vim
Plug 'jlanzarotta/bufexplorer'      " Easy buffer browsing
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
Plug 'JikkuJose/vim-visincr'        " Increment lists of numbers
Plug 'vim-scripts/taglist.vim'      " Source code browser for Vim

Plug 'junegunn/vim-easy-align'      " A simple, easy-to-use Vim alignment plugin
Plug 'godlygeek/tabular'            " Vim script for text filtering and alignment

" Find where Homebrew has installed fzf and add it to the path
execute 'set runtimepath+='.fnamemodify(systemlist('greadlink -f $(which fzf)')[0], ':h:h')

call plug#end()

map -a	:call SyntaxAttr()<CR>

" 'neomake/neomake'
"call neomake#configure#automake('nw', 1000) " Autobuild after 1s after writing

" nvim-treesitter/nvim-treesitter   {{{2
" ======================================
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "scala" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" w0rp/ale                          {{{2
" ======================================

" Autoconfigure from poetry
let g:ale_python_auto_poetry = 1
let g:ale_python_auto_virtualenv = 1
let g:ale_python_black_auto_poetry = 1
let g:ale_python_flake8_auto_poetry = 1
let g:ale_python_mypy_auto_poetry = 1
let g:ale_python_ruff_auto_poetry = 1

let g:ale_python_ruff_change_directory = 1  " Run ruff from the project root
let g:ale_set_loclist = 1                   " Use loclist instead of quickfix list
let g:ale_set_quickfix = 0                  " Use loclist instead of quickfix list
let g:ale_virtualtext_cursor = 0            " Do not display virtual text

let g:ale_python_ruff_options = "--force-exclude"

let g:ale_fixers = {
\   'python': [
\       'ruff',
\   ],
\}

let g:ale_linters = {
\   'python': [
\       'ruff', 'mypy'
\   ],
\}

lua <<EOF
require('lspconfig').ruff.setup {
    init_options = {
        settings = {
            args = { '--force-exclude' },
        }
    }
}
EOF

" junegunn/vim-easy-align           {{{2
" ======================================
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)<Paste>

let g:easy_align_delimiters = {
\ 't': { 'pattern': '\t' },
\ }

" Raimondi/delimitMate              {{{2
" ======================================
let delimitMate_expand_cr = 1

" scrooloose/nerdcommenter          {{{2
" ======================================

let NERDDefaultAlign='left'
let NERDSpaceDelims=1

" scrooloose/nerdtree               {{{2
" ======================================
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>E :NERDTreeFind<CR>

" fzf                               {{{2
" ======================================

set runtimepath+=/usr/local/opt/fzf
nmap <C-P> :FZF<CR>
" nmap <C-[> :call fzf#run({'source': 'fd --exclude={.git,.idea,.vscode,target,node_modules,build} --type f --hidden'})<CR>

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

" No vertical char
" set fillchars+=vert:\

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" simnalamburt/vim-mundo            {{{2
" ======================================
nnoremap <Leader>u :MundoToggle<CR>

" davidhalter/jedi-vim              {{{2
" ======================================
let g:jedi#force_py_version = 3

" mileszs/ack.vim                   {{{2
" ======================================
if executable('rg')
  let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
endif

" terryma/vim-expand-region         {{{2
" ======================================

" Alt up/down for expand and shrink
map <A-UP> <Plug>(expand_region_expand)
map <A-DOWN> <Plug>(expand_region_shrink)
vmap <A-UP> <Plug>(expand_region_expand)
vmap <A-DOWN> <Plug>(expand_region_shrink)

" tpope/vim-fugitive                {{{2
" ======================================

nnoremap <silent> <Leader>g :Git<CR>:only<CR>
nnoremap <silent> <Leader>1 :diffget //2<CR>
nnoremap <silent> <Leader>3 :diffget //3<CR>

" View commit history for the current file
nnoremap <silent> <Leader>h :0Gclog<CR>

command -nargs=* Glogv Git!  logv <args>
command -nargs=* Glogvv Git! logvv <args>

" vim-scripts/taglist.vim           {{{2
" ======================================

let g:tlist_scala_settings = 'scala;t:trait;c:class;T:type;' .
            \ 'm:method;C:constant;l:local;p:package;o:object'

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

" Switch off diff mode for all windows
function s:NoDiffAll()
    silent execute 'windo NoDiffThis'
endfunction
command -nargs=0 NoDiffAll call s:NoDiffAll(<f-args>)

" Format JSON
function s:FormatJson()
    silent execute '%! jq --indent 4 .'
endfunction
command -nargs=0 FormatJson call s:FormatJson(<f-args>)

function s:FormatJsonAndSort()
    silent execute '%! jq --indent 4 -S .'
endfunction
command -nargs=0 FormatJsonAndSort call s:FormatJsonAndSort(<f-args>)

" Format XML
function! s:FormatXML()
    silent execute '%! xmllint --format %'
endfunction
command -nargs=0 FormatXML call s:FormatXML(<f-args>)

function s:BrewfileAppendBrewDescription()
    execute 'read! brew info '.expand('<cword>').' | grep Description --context=1 | tail -n 1'
endfunction
command -nargs=0 BrewfileAppendBrewDescription call s:BrewfileAppendBrewDescription(<f-args>)

function s:BrewfileAppendCaskDescription()
    execute 'read! brew info --cask '.expand('<cword>').' | grep Description --context=1 | tail -n 1'
endfunction
command -nargs=0 BrewfileAppendCaskDescription call s:BrewfileAppendCaskDescription(<f-args>)

" Text functions                    {{{2
" ======================================

" Convert fancy punctuation back into ASCII
function s:FixSmartPunctuation()
    silent! %s/\%u00B4/'/g
    silent! %s/\%u0091/'/g
    silent! %s/\%u0092/'/g
    silent! %s/\%u0093/"/g
    silent! %s/\%u0094/"/g
    silent! %s/\%u200B//g
    silent! %s/\%u2013/-/g
    silent! %s/\%u2014/-/g
    silent! %s/\%u2018/'/g
    silent! %s/\%u2019/'/g
    silent! %s/\%u201C/"/g
    silent! %s/\%u201D/"/g
    silent! %s/\%u2026/.../g
endfunction
command -nargs=0 FixSmartPunctuation call s:FixSmartPunctuation(<f-args>)

" Remove ANSI codes
function s:FixAnsiCodes()
    silent! %s/\e\[[0-9;]\+[mK]//g
endfunction
command -nargs=0 FixAnsiCodes call s:FixAnsiCodes(<f-args>)

" Strip trailing whitespace characters from the entire file or a range
function s:StripTrailingWhitespace() range
    let l:save_search=@/
    let l:save_cursor = getpos('.')
    silent execute a:firstline.','a:lastline.'s/\s\+$//e'
    let @/=l:save_search
    silent call setpos('.', l:save_cursor)
endfunction
command -range=% StripTrailingWhitespace <line1>,<line2> call s:StripTrailingWhitespace()

" Wrap numbers which are at the end of a line with square brackets
function s:WrapTrailingDigits()
    silent execute '%s/\(\d\+\)$/[\1]/g'
endfunction
command -nargs=0 WrapTrailingDigits call s:WrapTrailingDigits(<f-args>)

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
set tags=.tags                              " Default tags files
set listchars=tab:>-,eol:$                  " Unprintable characters to display
set laststatus=2                            " Always have a statusline
set splitright                              " New vertical splits put the cursor on the right
set splitbelow                              " New horizontal splits put the cursor on the bottom
set shell=zsh                               " Use Zsh
TabStop 4                                   " Default to 4 spaces per tabstop

syntax on                                   " Syntax highlighting

" Use the system clipboard for everything
set clipboard=unnamedplus

" Enable extended character sets
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set guifontwide=NSimsun:h10

" Command / file completion
set noshellslash                            " Backslashes for filenames for ZIP plugin
set wildmenu                                " Display options when tab completing
set wildmode=list:full,full                 " List options but complete to full
set wildignorecase                          " Be case insensitive
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

    " Default to insert mode when opening a new terminal
    au TermOpen * startinsert

augroup END

" Use tabs in makefiles
autocmd FileType make set noexpandtab

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
    let SearchCmd=':Ack! '
    call feedkeys(SearchCmd."\<HOME>\<RIGHT>\<RIGHT>\<RIGHT>\<RIGHT>\<RIGHT>")
endfunction
command -nargs=0 SearchInteractive call s:SearchInteractive(<f-args>)

function! s:VisualSelection()
    if mode()=="v"
        let [line_start, column_start] = getpos("v")[1:2]
        let [line_end, column_end] = getpos(".")[1:2]
    else
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
    end
    if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
        let [line_start, column_start, line_end, column_end] =
        \   [line_end, column_end, line_start, column_start]
    end
    let lines = getline(line_start, line_end)
    if len(lines) == 0
            return ''
    endif
    let lines[-1] = lines[-1][: column_end - 1]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! s:SearchImmediate()
    let wordUnderCursor = expand("<cword>")
    let visualSelection = s:VisualSelection()
    let searchCmd=':Ack! '.l:wordUnderCursor
    call feedkeys(searchCmd)
    call feedkeys("\<CR>")
endfunction
command -nargs=0 SearchImmediate call s:SearchImmediate(<f-args>)

" Horrific SBT dependency trees                                             {{{1
" ==============================================================================

function DependencyTreeFoldLevel(lnum)
    let line=substitute(getline(a:lnum), "\\[info\\] ", "", "")
    let cleanLine=substitute(line, "\\(|\\|+\\|-\\)", " ", "g")
    let index=match(cleanLine, "\\S") / 2 - 1
    return (index == -1 ? 0 : index)
endfunction

function s:FoldDependencyTree()
    %g/|\s\+$/delete
    set foldmethod=expr
	set foldexpr=DependencyTreeFoldLevel(v:lnum)
endfunction
command -nargs=0 FoldDependencyTree call s:FoldDependencyTree(<f-args>)

" File types                                                                {{{1
" ==============================================================================

augroup VimrcFileTypeAutocommands
    au BufRead,BufNewFile *.applescript                 setlocal filetype=applescript
    au BufRead,BufNewFile *.boot                        setlocal filetype=clojure
    au BufRead,BufNewFile *.jsonld                      setlocal filetype=json
    au BufRead,BufNewFile *.jsw                         setlocal filetype=javascript
    au BufRead,BufNewFile *.log                         setlocal filetype=log
    au BufRead,BufNewFile *.md                          setlocal filetype=markdown
    au BufRead,BufNewFile *.pom                         setlocal filetype=xml
    au BufRead,BufNewFile *.yml                         setlocal filetype=yaml.ansible
    au BufRead,BufNewFile .bashrc                       setlocal filetype=sh
    au BufRead,BufNewFile Brewfile                      setlocal filetype=ruby
    au FileType           help                          setlocal conceallevel=0
augroup END

" Key mappings                                                              {{{1
" ==============================================================================

" Quick way to open a terminal
nmap <Leader>t :vsplit term://zsh<CR>:file zsh<CR>A

" Easier way to exit terminal mode
tnoremap <leader><Esc> <C-\><C-n>

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

" Quick way to edit .vimrc and colors
nmap <Leader>v :e ~/Dev/my-stuff/nvim/init.vim<CR><CR>
nmap <Leader>c :e ~/Dev/my-stuff/nvim/colors/lib/theme.py<CR><CR>

" Quick way to edit .zshrc
nmap <Leader>z :e ~/.zshrc<CR><CR>

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

" Grep
" CTRL-G interactive, CTRL-S immediate
nnoremap <C-G> :SearchInteractive <CR>
nnoremap <C-S> :SearchImmediate <CR>

" Show unprintable characters
nmap <Leader>w :set list!<CR>

" Strip trailing whitespace characters
nnoremap <silent> <Leader>W :StripTrailingWhitespace<CR>
vnoremap <silent> <Leader>W :StripTrailingWhitespace<CR>

" Map insert mode and command-line mode CTRL-Backspace to delete the previous word
imap <C-BS> <C-W>
cmap <C-BS> <C-W>

" Open the current file in the browser with git-open
nnoremap <Leader>G :!with-zsh git-open %<CR>

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

" vmap <Leader>e ':!echo <C-R><C-W> | with-zsh epoch-to-date<CR>'

" Align commas in paragraph: gaip*,

" Color scheme                                                              {{{1
" ==============================================================================

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

colorscheme sbw
"
" Visual-Multi should use normal visual style for cursors
let g:VM_Mono_hl   = 'Visual'
let g:VM_Extend_hl = 'Visual'
let g:VM_Cursor_hl = 'Visual'
let g:VM_Insert_hl = 'Visual'

" Experimental                                                              {{{1
" ==============================================================================

function! s:git_diff_branch()
  let l:base_commit = substitute(system('Git merge-base --fork-point main'), '\n\+$', '', '')
  exec 'Git difftool --name-only @ ' . l:base_commit
  call s:diff_current_quickfix_entry()
  " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
  " There's probably a better way to map this without changing the window
  copen
  nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
  wincmd p
endfunction
command! GitDiffBranch call s:git_diff_branch()

function! s:view_git_history() abort
  Git difftool --name-only ! !^@
  call s:diff_current_quickfix_entry()
  " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
  " There's probably a better way to map this without changing the window
  copen
  nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
  wincmd p
endfunction
command! DiffHistory call s:view_git_history()

function s:diff_current_quickfix_entry() abort
  " Cleanup windows
  for window in getwininfo()
    if window.winnr !=? winnr() && bufname(window.bufnr) =~? '^fugitive:'
      silent exe 'bdelete' window.bufnr
    endif
  endfor
  cc
  call s:add_mappings()
  let qf = getqflist({'context': 0, 'idx': 0})
  if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
    let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
    echom string(reverse(range(len(diff))))
    for i in reverse(range(len(diff)))
      exe (i ? 'leftabove' : 'rightbelow') 'vert diffsplit' fnameescape(diff[i].filename)
      call s:add_mappings()
    endfor
  endif
endfunction

function! s:add_mappings() abort
  nnoremap <buffer>]q :cnext <BAR> :call <sid>diff_current_quickfix_entry()<CR>
  nnoremap <buffer>[q :cprevious <BAR> :call <sid>diff_current_quickfix_entry()<CR>
  " Reset quickfix height. Sometimes it messes up after selecting another item
  11copen
  wincmd p
endfunction

function! s:sort_line()
    silent execute ":s/,/\r/g"
    silent execute ":'[,sort"
    silent execute " :,']j"
endfunction
command! SortLine call s:sort_line()
