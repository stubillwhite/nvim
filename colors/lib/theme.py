import vim

PALETTE = {
        'White':             '#ffffff',
        'LightGrey':         '#bcbcbc',
        'DarkGrey':          '#585858',
        'VeryDarkGrey':      '#464646',
        'LightBlack':        '#262626',
        'Blue':              '#5f87af',
        'Green':             '#87af87',
        'Yellow':            '#ffffaf',
        'LightBlue':         '#8fafd7',
        'BlueGreen':         '#5f8787',
        'Red':               '#af5f5f',
        'Purple':            '#8787af',
        'HighlighterRed':    '#432222',
        'HighlighterGreen':  '#283C28',
        'HighlighterBlue':   '#223243',
        'HighlighterPurple': '#383855',
        'DiffGreen':         "#2B3328",
        'DiffYellow':        "#49443C",
        'DiffRed':           "#43242B",
        'DiffBlue':          "#252535",
        }

MAPPINGS = {
        # Normal text
        'Normal':            { 'guifg': 'LightGrey',  'guibg': 'LightBlack'   },

        # Selection
        'Selection':         { 'guifg': 'White',      'guibg': 'VeryDarkGrey' },
        'Visual':            { 'link':  'Selection'   },
        'VisualNOS':         { 'link':  'Visual'      },
        'Search':            { 'link':  'Selection'   },
        'IncSearch':         { 'link':  'Search'      },
        'MatchParen':        { 'link':  'Search'      },
        'CursorLine':        { 'link':  'Search'      },
        'ColorColumn':       { 'link':  'Search'      },

        # Gutter
        'LineNr':            { 'link':  'Comment'     },
        'SignColumn':        { 'link':  'Comment'     },
        'Folded':            { 'link':  'Comment'     },
        'FoldColumn':        { 'link':  'Comment'     },
        'EndOfBuffer':       { 'link':  'Comment'     },

        # Splitter
        'VertSplit':         { 'link':  'Comment'     },

        # Whitespace
        'NonText':           { 'link':  'Comment'     },

        # General messages
        'ErrorMsg':          { 'guifg': 'Red'         },
        'MoreMsg':           { 'guifg': 'LightBlue'   },
        'ModeMsg':           { 'guifg': 'LightBlue'   },
        'Question':          { 'link':  'Normal'      },
        'WarningMsg':        { 'guifg': 'Yellow'      },

        # General UI highlights
        'Directory':         { 'link':  'Keyword'     },
        'Title':             { 'link':  'Keyword'     },
        'SpecialKey':        { 'link':  'Keyword'     },

        # Menu
        'Pmenu':             { 'guifg': 'LightGrey',  'guibg': 'VeryDarkGrey' },
        'PmenuSbar':         { 'guifg': 'LightGrey',  'guibg': 'VeryDarkGrey' },
        'PmenuSel':          { 'link':  'Selection'   },
        #call s:create_highlight('PmenuThumb', s:none, s:bg4)

        # Status line and wild menu
        'StatusLine':        { 'link':  'PMenu'       },
        'WildMenu':          { 'link':  'PmenuSel'    },

        # Basic statements and keywords
        'Statement':         { 'guifg': 'LightBlue'   },
        'Keyword':           { 'guifg': 'LightBlue'   },
        'Conditional':       { 'link':  'Keyword'     },
        'Repeat':            { 'link':  'Keyword'     },
        'Label':             { 'link':  'Keyword'     },
        'Exception':         { 'link':  'Keyword'     },
        'Operator':          { 'link':  'Keyword'     },
        'Type':              { 'link':  'Keyword'     },
        'Special':           { 'link':  'Normal'      },
        'Comment':           { 'guifg': 'DarkGrey'    },
        'Todo':              { 'guifg': 'Yellow'      },
        'Error':             { 'guifg': 'Red'         },

        # Identifiers
        'Function':          { 'guifg': 'Yellow'},
        'Identifier':        { 'guifg': 'Blue'},
        'Variable':          { 'link':  'Identifier'  },

        # Preprocessor and macro
        'PreProc':           { 'guifg': 'BlueGreen'},
        'Include':           { 'link':  'PreProc'     },
        'Define':            { 'link':  'PreProc'     },
        'Macro':             { 'link':  'PreProc'     },
        'PreCondit':         { 'link':  'PreProc'     },

        # Generic constant
        'Constant':          { 'guifg': 'BlueGreen'},
        'Character':         { 'link':  'Constant'    },
        'Boolean':           { 'link':  'Constant'    },
        'Number':            { 'link':  'Constant'    },
        'Float':             { 'link':  'Constant'    },

        # ALE
        'ALEError':          { 'link':  'ErrorMsg'    },
        'ALEWarning':        { 'link':  'WarningMsg'  },
        'ALEInfo':           { 'link':  'MoreMsg'     },
        'ALEStyleError':     { 'link':  'ALEError'    },
        'ALEStyleWarning':   { 'link':  'ALEWarning'  },

        # Spelling
        'SpellBad':          { 'link':  'ErrorMsg'    },
        'SpellCap':          { 'link':  'WarningMsg'  },
        'SpellRare':         { 'link':  'WarningMsg'  },
        'SpellLocal':        { 'link':  'ErrorMsg'    },

        'NERDTreeDir':       { 'link':  'Keyword'     },
        'NERDTreeDirSlash':  { 'link':  'NERDTreeDir' },
        'NERDTreeOpenable':  { 'link':  'NERDTreeDir' },
        'NERDTreeClosable':  { 'link':  'NERDTreeDir' },
        'NERDTreeFile':      { 'link':  'Normal'      },
        'NERDTreeExecFile':  { 'link':  'ErrorMsg '   },
        'NERDTreeUp':        { 'link':  'NERDTreeDir' },
        'NERDTreeCWD':       { 'link':  'NERDTreeDir' },
        'NERDTreeHelp':      { 'link':  'Normal'      },
        'NERDTreeToggleOn':  { 'link':  'Normal'      },
        'NERDTreeToggleOff': { 'link':  'Normal'      },
        }

#call s:create_highlight('DiffDelete', 'NONE', s:PaletteDiffRed)
#call s:create_highlight('DiffAdd',    'NONE', s:PaletteDiffGreen)
#call s:create_highlight('DiffChange', 'NONE', s:PaletteDiffBlue)
#call s:create_highlight('DiffText',   'NONE', s:PaletteDiffYellow)

def create_color_mapping(group, props):
    deref_color = lambda x: PALETTE.get(x, x)

    vim.command(f'hi clear {group}', )

    if 'link' in props:
        cmd = f'hi link {group} {props["link"]}'
    else:
        props_str = ' '.join([f'{k}={deref_color(v)}' for k,v in props.items()])
        cmd = f'hi {group} {props_str}'

    vim.command(cmd)

def create_theme():
    for group, props in MAPPINGS.items():
        create_color_mapping(group, props)
