-- vim:fdm=marker

-- https://neovim.io/doc/user/lua-guide.html

-- References
-- https://github.com/creativenull/nvim-config/tree/main
-- https://www.reddit.com/r/neovim/comments/khk335/lua_configuration_global_vim_is_undefined/
-- https://www.jonashietala.se/blog/2023/10/01/rewriting_my_neovim_config_in_lua/

-- Prerequisites                                                            {{{1
-- =============================================================================

local vim = vim

-- Paths to this configuration

local config_file = debug.getinfo(1, 'S').source:sub(2)
local config_root = vim.fn.fnamemodify(vim.loop.fs_realpath(config_file) or config_file, ':p:h')

vim.g.TmpDir = vim.fn.expand('~/.config/nvim-tmp')

vim.g.python3_host_prog = config_root .. '/python-nvim/.venv/bin/python'

-- Set <Leader> to something easier to reach
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local keymap_opts = { noremap = true }
local silent_keymap_opts = { noremap = true, silent = true }

-- Plugin list                                                              {{{1
-- =============================================================================

-- Built-in plugins                 {{{2
-- =====================================

vim.cmd("packadd cfilter")                  -- Filter quickfix or location list

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim-lua-plug')

-- Libraries
Plug 'nvim-lua/plenary.nvim'                -- Async library required by other plugins


-- TODO: Review
Plug 'nvim-telescope/telescope.nvim'

-- Cosmetics                        {{{2
-- =====================================

Plug 'nvim-lualine/lualine.nvim'            -- A blazing fast and easy to configure Neovim statusline written in Lua.

-- Syntax and static checking       {{{2
-- =====================================

Plug 'w0rp/ale'                             -- Asynchronous Lint Engine
Plug 'neovim/nvim-lspconfig'                -- Quickstart configs for Nvim LSP

-- Languages
Plug 'davidhalter/jedi-vim'                 -- Smarter Python integration
Plug 'vim-scripts/applescript.vim'          -- Applescript syntax highlighting
Plug 'othree/xml.vim'                       -- Helps editing XML files
Plug 'aliou/bats.vim'                       -- BATS script testing language
Plug 'hashivim/vim-terraform'               -- Basic vim/terraform integration

-- Interface                        {{{2
-- =====================================

Plug('ycm-core/YouCompleteMe',              -- Smarter completion
    { ['do'] = './install.py' }
)

Plug 'jlanzarotta/bufexplorer'              -- Easy buffer browsing
Plug 'mileszs/ack.vim'                      -- Vim plugin for the Perl module / CLI script 'ack'
Plug 'scrooloose/nerdcommenter'             -- Easy multi-language commenting
Plug 'scrooloose/nerdtree'                  -- Easy file browsing
Plug 'simnalamburt/vim-mundo'               -- Visualise the undo graph
Plug 'terryma/vim-expand-region'            -- Incremental selection widening
Plug 'tpope/vim-endwise'                    -- Smart closing of data strutures
Plug 'tpope/vim-fugitive'                   -- Git integration
Plug 'lewis6991/gitsigns.nvim'              -- Git visual markers
Plug 'tpope/vim-unimpaired'                 -- Incredibly useful text navigation and manipulation shortcuts
Plug 'vim-scripts/taglist.vim'              -- Source code browser for Vim
Plug 'neomake/neomake'                      -- Asynchronous make

Plug 'junegunn/vim-easy-align'              -- A simple, easy-to-use Vim alignment plugin
Plug 'godlygeek/tabular'                    -- Vim script for text filtering and alignment

-- Experimental                     {{{2
-- =====================================

-- Plug 'folke/trouble.nvim'
Plug 'sindrets/diffview.nvim'

vim.call('plug#end')

-- map -a	:call SyntaxAttr()<CR>

-- nvim-treesitter/nvim-treesitter   {{{2
-- ======================================
-- lua << EOF
-- require'nvim-treesitter.configs'.setup {
--   -- A list of parser names, or "all"
--   ensure_installed = { "scala" },
--
--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,
--
--   -- List of parsers to ignore installing (for "all")
--   ignore_install = { "javascript" },
--
--   highlight = {
--     -- `false` will disable the whole extension
--     enable = true,
--
--     -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--     -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--     -- the name of the parser)
--     -- list of language that will be disabled
--     disable = { "c", "rust" },
--
--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },
-- }
-- EOF

-- Plugin configuration                                                     {{{1
-- =============================================================================

-- Cosmetics                        {{{2
-- =====================================

-- nvim-lualine/lualine.nvim        {{{3
-- =====================================

require('lualine').setup({
    options = { theme  = 'seoul256' },
    sections = {
    lualine_a = {'mode', 'paste'},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = { { 'diagnostics', symbols = { error = '✘ ', warn = '✱ ', info = '! ' } } },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
})

-- Syntax and static checking       {{{2
-- =====================================

-- w0rp/ale                         {{{3
-- =====================================

-- Autoconfigure from poetry
vim.g.ale_python_auto_poetry           = 1
vim.g.ale_python_auto_virtualenv       = 1
vim.g.ale_python_black_auto_poetry     = 1
vim.g.ale_python_flake8_auto_poetry    = 1
vim.g.ale_python_mypy_auto_poetry      = 1
vim.g.ale_python_ruff_auto_poetry      = 1

vim.g.ale_python_ruff_change_directory = 1  -- Run ruff from the project root
vim.g.ale_set_loclist                  = 1  -- Use loclist instead of quickfix list
vim.g.ale_set_quickfix                 = 0  -- Use loclist instead of quickfix list
vim.g.ale_virtualtext_cursor           = 0  -- Do not display virtual text

vim.g.ale_python_ruff_options          = "--force-exclude"

vim.g.ale_fixers = {
    python = {'ruff' },
}

vim.g.ale_linters = {
    python = { 'ruff', 'mypy' },
}

-- neovim/nvim-lspconfig            {{{3
-- =====================================

local ruff_lsp_config = {
    init_options = {
        settings = {
            args = { '--force-exclude' },
        }
    }
}

if vim.lsp and vim.lsp.config then
    vim.lsp.config('ruff', ruff_lsp_config)
    vim.lsp.enable('ruff')
else
    require('lspconfig').ruff.setup(ruff_lsp_config)
end

-- davidhalter/jedi-vim             {{{3
-- =====================================

vim.g['jedi#force_py_version'] = 3

-- Interface                        {{{2
-- =====================================

-- jlanzarotta/bufexplorer'         {{{3
-- =====================================

vim.api.nvim_set_keymap('n', "<leader>b", ":BufExplorer<cr>", keymap_opts)
vim.g.bufExplorerSortBy = 'name'

-- mileszs/ack.vim                  {{{3
-- =====================================

vim.g.ackprg = 'rg --vimgrep --type-not sql --smart-case'

-- scrooloose/nerdcommenter         {{{3
-- =====================================

vim.g.NERDDefaultAlign = 'left'
vim.g.NERDSpaceDelims = 1

-- scrooloose/nerdtree               {{3
-- =====================================

vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeShowHidden = 0
vim.api.nvim_set_keymap('n', "<leader>e", ":NERDTreeToggle<cr>", keymap_opts)
vim.api.nvim_set_keymap('n', "<leader>E", ":NERDTreeFind<cr>", keymap_opts)

-- simnalamburt/vim-mundo           {{{3
-- =====================================

vim.api.nvim_set_keymap('n', "<leader>u", ":MundoToggle<cr>", keymap_opts)

-- terryma/vim-expand-region        {{{3
-- =====================================

-- Alt up/down for expand and shrink
vim.keymap.set('n', '<A-Up>', '<Plug>(expand_region_expand)', {})
vim.keymap.set('n', '<A-Down>', '<Plug>(expand_region_shrink)', {})
vim.keymap.set('v', '<A-Up>', '<Plug>(expand_region_expand)', {})
vim.keymap.set('v', '<A-Down>', '<Plug>(expand_region_shrink)', {})

-- tpope/vim-fugitive               {{{3
-- =====================================

vim.keymap.set('n', '<Leader>g', '<cmd>Git<cr><cmd>only<cr>', silent_keymap_opts)
vim.keymap.set('n', '<Leader>1', '<cmd>diffget //2<cr>', silent_keymap_opts)
vim.keymap.set('n', '<Leader>3', '<cmd>diffget //3<cr>', silent_keymap_opts)

-- View commit history for the current file
vim.keymap.set('n', '<Leader>h', '<cmd>0Gclog<cr>', silent_keymap_opts)

vim.api.nvim_create_user_command('Glogv',
    function(opts)
        vim.cmd('enew')

        local args = table.concat(opts.fargs, ' ')
        local cmd = 'git logv ' .. args

        vim.cmd('0read !' .. cmd)
        vim.cmd('silent 1delete')
        vim.bo.filetype = 'git'
        vim.bo.buftype = 'nofile'
        vim.bo.bufhidden = 'wipe'
        vim.bo.swapfile = false
        vim.bo.modifiable = false
        vim.bo.modified = false

        vim.keymap.set('n', '<F12>',
            function()
                local word = vim.fn.expand('<cword>')
                vim.cmd('DiffviewOpen ' .. word .. '^!')
            end,
            { buffer = true, silent = true })

    end,
    { nargs = '*' }
)

-- junegunn/vim-easy-align          {{{3
-- =====================================

vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', {})
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', {})

vim.g.easy_align_delimiters = {
    t = { pattern = '\t' },
}

-- Experimental                     {{{2
-- =====================================

-- sindrets/diffview.nvim           {{{3
-- =====================================

require('diffview').setup({
    use_icons = false,                      -- No nvim-web-devicons
})

-- nmap <C-[> :call fzf#run({'source': 'fd --exclude={.git,.idea,.vscode,target,node_modules,build} --type f --hidden'})<CR>
--

-- Functions                                                                {{{1
-- =============================================================================

-- General Vim functions            {{{2
-- =====================================

-- Find where Homebrew has installed fzf and add it to the path
local fzf_path = vim.fn.exepath('fzf')
if fzf_path ~= '' then
    vim.opt.runtimepath:append(vim.fn.fnamemodify(vim.fn.resolve(fzf_path), ':h:h'))
end

vim.keymap.set('n', '<C-P>', '<cmd>FZF<cr>', keymap_opts)

-- Set all the relevant tab options to the specified level
vim.api.nvim_create_user_command('TabStop',
    function(opts)
        local n = tonumber(opts.fargs[1])
        vim.o.tabstop = n
        vim.o.shiftwidth = n
        vim.o.softtabstop = n
    end,
    { nargs = 1 }
)

-- Switch off diff mode for all windows
vim.api.nvim_create_user_command('NoDiffAll',
    function()
        vim.cmd([[silent execute 'windo diffoff']])
    end,
    { nargs = 0 }
)

-- Format JSON
vim.api.nvim_create_user_command('FormatJson',
    function()
        vim.cmd([[silent execute '%! jq --indent 4 .']])
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command('FormatJsonAndSort',
    function()
        vim.cmd([[silent execute '%! jq --indent 4 -S .']])
    end,
    { nargs = 0 }
)

-- Format XML
vim.api.nvim_create_user_command('FormatXML',
    function()
        vim.cmd([[silent execute '%! xmllint --format %']])
    end,
    { nargs = 0 }
)

-- Text functions                    {{{2
-- ======================================

-- Convert fancy punctuation back into ASCII
vim.api.nvim_create_user_command('FixSmartPunctuation',
    function()
        vim.cmd([[silent! %s/\%u00B4/'/g]])
        vim.cmd([[silent! %s/\%u0091/'/g]])
        vim.cmd([[silent! %s/\%u0092/'/g]])
        vim.cmd([[silent! %s/\%u0093/"/g]])
        vim.cmd([[silent! %s/\%u0094/"/g]])
        vim.cmd([[silent! %s/\%u200B//g]])
        vim.cmd([[silent! %s/\%u2013/-/g]])
        vim.cmd([[silent! %s/\%u2014/-/g]])
        vim.cmd([[silent! %s/\%u2018/'/g]])
        vim.cmd([[silent! %s/\%u2019/'/g]])
        vim.cmd([[silent! %s/\%u201C/"/g]])
        vim.cmd([[silent! %s/\%u201D/"/g]])
        vim.cmd([[silent! %s/\%u2026/.../g]])
    end,
    { nargs = 0 }
)

-- Remove ANSI codes
vim.api.nvim_create_user_command('FixAnsiCodes',
    function()
        vim.cmd([[silent! %s/\e\[[0-9;]\+[mK]//g]])
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command('StripTrailingWhitespace',
    function(opts)
        local saved_search = vim.fn.getreg('/')
        local saved_search_type = vim.fn.getregtype('/')
        local saved_cursor = vim.api.nvim_win_get_cursor(0)

        vim.cmd(string.format([[silent %d,%ds/\s\+$//e]], opts.line1, opts.line2))
        vim.fn.setreg('/', saved_search, saved_search_type)
        vim.api.nvim_win_set_cursor(0, saved_cursor)
    end,
    { nargs = 0, range = '%' }
)

-- Search                            {{{2
-- ======================================

local function get_visual_selection()
    local mode = vim.fn.mode()
    local start_pos = mode == 'v' and vim.fn.getpos('v') or vim.fn.getpos("'<")
    local end_pos = mode == 'v' and vim.fn.getpos('.') or vim.fn.getpos("'>")
    local start_line, start_col = start_pos[2], start_pos[3]
    local end_line, end_col = end_pos[2], end_pos[3]

    if start_line > end_line or (start_line == end_line and start_col > end_col) then
        start_line, end_line = end_line, start_line
        start_col, end_col = end_col, start_col
    end

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    if #lines == 0 then
        return ''
    end

    lines[1] = string.sub(lines[1], start_col, -1)
    if #lines == 1 then
        lines[1] = string.sub(lines[1], 1, end_col - start_col + 1)
    else
        lines[#lines] = string.sub(lines[#lines], 1, end_col)
    end

    return table.concat(lines, '\n')
end

local function get_search_term()
    local mode = vim.fn.mode()

    if mode == 'v' or mode == 'V' or mode == '\22' then
        return get_visual_selection()
    end

    return vim.fn.expand('<cword>')
end

local function search_interactive()
    local term = get_search_term()
    if term == nil or term == '' then
        return
    end

    local keys = vim.api.nvim_replace_termcodes(':Ack! ' .. term, true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
end

local function search_immediate()
    local term = get_search_term()
    if term == nil or term == '' then
        return
    end

    vim.cmd('Ack! ' .. vim.fn.escape(term, [[\ ]]))
end

local function get_visual_search_pattern()
    local selection = get_visual_selection()
    if selection == '' then
        return nil
    end

    local pattern = vim.fn.escape(selection, '/\\.*$^~[')
    return vim.fn.substitute(pattern, [[\_s\+]], [[\\_s\\+]], 'g')
end

local function search_visual_selection(backward)
    local pattern = get_visual_search_pattern()
    if not pattern then
        return
    end

    vim.fn.setreg('/', pattern)
    vim.cmd('normal! ' .. (backward and 'N' or 'n'))
end

-- Settings                                                                 {{{1
-- =============================================================================

-- General settings

vim.o.backup        = true                      -- Use backup files
vim.o.hidden        = true                      -- Keep buffers open when not displayed
vim.o.ruler         = true                      -- Show the file position
vim.o.copyindent    = true                      -- Copy indentation characters
vim.o.clipboard     = 'unnamedplus'             -- Use the system clipboard for everything
vim.o.showcmd       = true                      -- Show incomplete commands
vim.o.showmode      = false                     -- Don't show the active mode, mirrored in lualine
vim.o.incsearch     = true                      -- Search incrementally
vim.o.hlsearch      = true                      -- Search highlighting
vim.o.history       = 1000                      -- Keep more history
vim.o.visualbell    = true                      -- No beep
vim.o.expandtab     = true                      -- No tabs
vim.o.wrap          = false                     -- No wrapping text
vim.o.joinspaces    = false                     -- Single-space when joining sentences
vim.o.title         = true                      -- Set the title of the terminal
vim.o.ignorecase    = true                      -- Case insensitive by default...
vim.o.smartcase     = true                      -- ...but case sensitive if term includes uppercase
vim.o.scrolloff     = 2                         -- Keep some context when scrolling vertically
vim.o.sidescrolloff = 2                         -- Keep some context when scrolling horizontally
vim.o.startofline   = false                     -- Keep horizontal cursor position when scrolling
vim.o.virtualedit   = ''                        -- No virtual edit
vim.o.timeoutlen    = 500                       -- Timeout to press a key combination
vim.o.report        = 0                         -- Always report changes
vim.o.undofile      = true                      -- Allow undo history to persist between sessions
vim.o.tags          = '.tags'                   -- Default tags files
vim.o.listchars     = 'tab:>-,eol:$'            -- Unprintable characters to display
vim.o.laststatus    = 2                         -- Always have a statusline
vim.o.splitright    = true                      -- New vertical splits put the cursor on the right
vim.o.splitbelow    = true                      -- New horizontal splits put the cursor on the bottom
vim.o.shell         = 'zsh'                     -- Use Zsh

vim.opt.formatoptions:append('n')               -- Format respects numbered/bulleted lists
vim.opt.iskeyword:append('-')                   -- Dash is part of a word for movement purposes

vim.cmd("TabStop 4")                            -- Default to 4 spaces per tabstop

-- syntax on                                   " Syntax highlighting
-- Enable extended character sets
-- set encoding=utf-8
-- set fileencoding=utf-8
-- set fileencodings=ucs-bom,utf8,prc
-- set guifontwide=NSimsun:h10

-- Command / file completion
-- if has("win32")
--     set noshellslash                        " Backslashes for filenames for ZIP plugin
-- endif
vim.o.wildmenu       = true                    -- Display options when tab completing
vim.o.wildmode       = 'full'                  -- Complete on the first Tab press, like the old config
vim.o.wildoptions    = 'tagfile'               -- Keep legacy wildmenu completion instead of the popup menu
vim.o.wildignorecase = true                    -- Be case insensitive
vim.opt.wildignore   = { '*.class', '*.obj', '*.pyc', '*/.hg/*', '*/.git/*', '*/.svn/*', '*/bld/*', '*/bin/*' }

-- Misc options
vim.g.netrw_altv = 1                           -- Netrw vertical split puts cursor on the right
--
-- Standard plugin to allow % to match keywords as well as braces
vim.cmd("packadd matchit")

-- Store Undo/Backup/Swap files in a temporary directory
local function create_directory(path)
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, 'p')
    end
end

vim.o.undodir = vim.g.TmpDir .. '/undo'
vim.o.backupdir = vim.g.TmpDir .. '/backup'
vim.o.directory = vim.g.TmpDir .. '/swap'
create_directory(vim.fn.expand(vim.o.undodir))
create_directory(vim.fn.expand(vim.o.backupdir))
create_directory(vim.fn.expand(vim.o.directory))

-- Error and make files
vim.o.shellpipe = '2>&1 | tee'
vim.o.errorfile = vim.g.TmpDir .. '/error_file.txt'
vim.o.makeef = vim.g.TmpDir .. '/make_error_file.txt'

-- Autocmds
local editing_group = vim.api.nvim_create_augroup('VimrcEditingAutocommands', { clear = true })

vim.api.nvim_create_autocmd('BufReadPost', {
    group = editing_group,
    pattern = '*',
    callback = function()
        local line = vim.fn.line([['"]])
        if line > 0 and line <= vim.fn.line('$') then
            vim.cmd([[normal! g'"]])
        end
    end,
})

vim.api.nvim_create_autocmd('VimResized', {
    group = editing_group,
    pattern = '*',
    command = 'wincmd =',
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = editing_group,
    pattern = '*',
    command = 'syntax sync fromstart',
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = editing_group,
    pattern = '*',
    command = 'startinsert',
})

-- Use tabs in makefiles
vim.api.nvim_create_autocmd('FileType', {
    group = editing_group,
    pattern = 'make',
    callback = function()
        vim.opt_local.expandtab = false
    end,
})

-- File comparison options
vim.opt.diffopt = { 'filler', 'iwhite' }

if vim.fn.has('unix') == 0 then
    function _G.MyDiff()
        local opt = ''
        if vim.o.diffopt:match('icase') then
            opt = opt .. '-i '
        end
        if vim.o.diffopt:match('iwhite') then
            opt = opt .. '-b '
        end

        vim.cmd(string.format([[silent execute '!"%s/diff.exe" -r %s%s %s > %s']],
            vim.env.VIMRUNTIME,
            opt,
            vim.v.fname_in,
            vim.v.fname_new,
            vim.v.fname_out
        ))
    end

    vim.o.diffexpr = 'v:lua.MyDiff()'
end

-- Search                                                                   {{{1
-- =============================================================================

vim.api.nvim_create_user_command('SearchInteractive', search_interactive, { nargs = 0 })
vim.api.nvim_create_user_command('SearchImmediate', search_immediate, { nargs = 0 })

-- File types                                                                {{{1
-- ==============================================================================

local filetype_group = vim.api.nvim_create_augroup('VimrcFileTypeAutocommands', { clear = true })
local filetype_patterns = {
    ['*.applescript'] = 'applescript',
    ['*.boot'] = 'clojure',
    ['*.jsonld'] = 'json',
    ['*.jsw'] = 'javascript',
    ['*.log'] = 'log',
    ['*.md'] = 'markdown',
    ['*.pom'] = 'xml',
    ['*.yml'] = 'yaml.ansible',
    ['.bashrc'] = 'sh',
    ['Brewfile'] = 'ruby',
}

for pattern, filetype in pairs(filetype_patterns) do
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        group = filetype_group,
        pattern = pattern,
        callback = function(args)
            vim.bo[args.buf].filetype = filetype
        end,
    })
end

vim.api.nvim_create_autocmd('FileType', {
    group = filetype_group,
    pattern = 'help',
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- Key mappings                                                              {{{1
-- ==============================================================================

-- Quick way to open a terminal
vim.keymap.set('n', '<Leader>t', function()
    vim.cmd('vsplit term://zsh')
    vim.cmd('file zsh')
    vim.cmd('startinsert')
end, keymap_opts)

-- Easier way to exit terminal mode
vim.keymap.set('t', '<leader><Esc>', '<C-\\><C-n>', keymap_opts)

-- <Space> in normal mode removes highlighted search
vim.keymap.set('n', '<Space>', '<cmd>:nohlsearch<cr>:echo "Search highlight off"<cr>')

-- Use semi-colon as an alias for colon for easier access to Ex commands
vim.keymap.set({'n', 'v'}, ';', ':')

-- Swap ` and ' because ` functionality is more useful but the key is hard to reach
vim.keymap.set('n', "'", '`', keymap_opts)
vim.keymap.set('n', '`', "'", keymap_opts)

-- Navigate wrapped lines more easily
vim.keymap.set('n', 'j', 'gj', keymap_opts)
vim.keymap.set('n', 'k', 'gk', keymap_opts)

-- Quick way to edit .vimrc, colors, and .zshrc
vim.keymap.set('n', '<Leader>v', '<cmd>e ' .. vim.fn.fnameescape(config_root .. '/init.lua') .. '<cr>')
vim.keymap.set('n', '<Leader>c', '<cmd>e ' .. vim.fn.fnameescape(config_root .. '/colors/lib/theme.py') .. '<cr>')
vim.keymap.set('n', '<Leader>z', '<cmd>e ~/dev/my-stuff/dotfiles/zsh/.zshrc<cr>')

-- Copy-all to clipboard and paste-all from clipboard
vim.keymap.set('n', '<Leader>ac', '<cmd>%y+<cr>', silent_keymap_opts)
vim.keymap.set('n', '<Leader>ap', function()
    local clipboard = vim.fn.getreg('+')
    local lines = vim.split(clipboard, '\n', { plain = true })
    if lines[#lines] == '' then
        table.remove(lines, #lines)
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, silent_keymap_opts)

-- Fast window navigation
vim.keymap.set({ 'n', 'v' }, '<S-Left>', '<C-w>h', keymap_opts)
vim.keymap.set({ 'n', 'v' }, '<S-Down>', '<C-w>j', keymap_opts)
vim.keymap.set({ 'n', 'v' }, '<S-Up>', '<C-w>k', keymap_opts)
vim.keymap.set({ 'n', 'v' }, '<S-Right>', '<C-w>l', keymap_opts)

-- Use standard regexes for search, not Vim regexes
vim.keymap.set('n', '/', '/\\v', keymap_opts)
vim.keymap.set('v', '/', '/\\v', keymap_opts)

-- Grep
-- CTRL-G interactive, CTRL-S immediate
vim.keymap.set({ 'n', 'v' }, '<C-G>', search_interactive, keymap_opts)
vim.keymap.set({ 'n', 'v' }, '<C-S>', search_immediate, keymap_opts)

-- Show unprintable characters
vim.keymap.set('n', '<Leader>w', '<cmd>set list!<cr>', keymap_opts)

-- Strip trailing whitespace characters
vim.keymap.set('n', '<Leader>W', '<cmd>StripTrailingWhitespace<cr>', silent_keymap_opts)
vim.keymap.set('v', '<Leader>W', [[:<C-U>'<,'>StripTrailingWhitespace<CR>]], silent_keymap_opts)

-- Map insert mode and command-line mode CTRL-Backspace to delete the previous word
vim.keymap.set('i', '<C-BS>', '<C-W>', keymap_opts)
vim.keymap.set('c', '<C-BS>', '<C-W>', keymap_opts)

-- Open the current file in the browser with git-open
vim.keymap.set('n', '<Leader>G', '<cmd>!with-zsh git-open %<cr>', keymap_opts)

-- VimTip #171 -- Search for visually selected text
vim.keymap.set('v', '*', function()
    search_visual_selection(false)
end, silent_keymap_opts)
vim.keymap.set('v', '#', function()
    search_visual_selection(true)
end, silent_keymap_opts)

-- vmap <Leader>e ':!echo <C-R><C-W> | with-zsh epoch-to-date<CR>'

-- Align commas in paragraph: gaip*,

-- Color scheme                                                             {{{1
-- =============================================================================

vim.cmd.colorscheme('sbw')

-- Visual-Multi should use normal visual style for cursors
vim.g.VM_Mono_hl   = 'Visual'
vim.g.VM_Extend_hl = 'Visual'
vim.g.VM_Cursor_hl = 'Visual'
vim.g.VM_Insert_hl = 'Visual'

-- Experimental                                                              {{{1
-- ==============================================================================

-- function! s:git_diff_branch()
--   let l:base_commit = substitute(system('Git merge-base --fork-point main'), '\n\+$', '', '')
--   exec 'Git difftool --name-only @ ' . l:base_commit
--   call s:diff_current_quickfix_entry()
--   " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
--   " There's probably a better way to map this without changing the window
--   copen
--   nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
--   wincmd p
-- endfunction
-- command! GitDiffBranch call s:git_diff_branch()

-- function! s:view_git_history() abort
--   Git difftool --name-only ! !^@
--   call s:diff_current_quickfix_entry()
--   " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
--   " There's probably a better way to map this without changing the window
--   copen
--   nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
--   wincmd p
-- endfunction
-- command! DiffHistory call s:view_git_history()

-- function s:diff_current_quickfix_entry() abort
--   " Cleanup windows
--   for window in getwininfo()
--     if window.winnr !=? winnr() && bufname(window.bufnr) =~? '^fugitive:'
--       silent exe 'bdelete' window.bufnr
--     endif
--   endfor
--   cc
--   call s:add_mappings()
--   let qf = getqflist({'context': 0, 'idx': 0})
--   if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
--     let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
--     echom string(reverse(range(len(diff))))
--     for i in reverse(range(len(diff)))
--       exe (i ? 'leftabove' : 'rightbelow') 'vert diffsplit' fnameescape(diff[i].filename)
--       call s:add_mappings()
--     endfor
--   endif
-- endfunction

-- function! s:add_mappings() abort
--   nnoremap <buffer>]q :cnext <BAR> :call <sid>diff_current_quickfix_entry()<CR>
--   nnoremap <buffer>[q :cprevious <BAR> :call <sid>diff_current_quickfix_entry()<CR>
--   " Reset quickfix height. Sometimes it messes up after selecting another item
--   11copen
--   wincmd p
-- endfunction

-- function! s:sort_line()
--     silent execute ":s/,/\r/g"
--     silent execute ":'[,sort"
--     silent execute " :,']j"
-- endfunction
-- command! SortLine call s:sort_line()
