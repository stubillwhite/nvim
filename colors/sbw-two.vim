" vim:fdm=marker

" Use :Inspect to view syntax highlighting

" Python module                                                             {{{1
" ==============================================================================

" Get the current plugin path
let s:plugin_path = expand('<sfile>:p:h')

function! s:loadTheme()
python << endpython

import os
import sys
import vim

# Add the Python lib source to the module path
plugin_path = vim.eval("s:plugin_path")
python_module_path = os.path.abspath('%s/lib' % (plugin_path))
sys.path.append(python_module_path)

# Import
from theme import create_theme

create_theme()

endpython
endfunction

" Theme setup                                                               {{{1
" ==============================================================================

set bg=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

call s:loadTheme()
