" vim:fdm=marker
"
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

function! DisplaySynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call DisplaySynStack()<CR>
