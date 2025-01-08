vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ignore_install = {},
    modules = {},
    matchup = { enable = true },
    ensure_installed = {
      'c',
      'cpp',
      'sql',
      'vimdoc',
      'vim',
      'bash',
      'markdown',
      'markdown_inline',
      'html',
      'css',
      'scss',
      'json',

      'lua',
      'python',
      'rust',
      'go',
      'php',
      'phpdoc',

      'tsx',
      'javascript',
      'jsdoc',
      'typescript',
      'vue',
      'svelte',
    },
    sync_install = false,
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    -- TODO: learn these textobject
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }

  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  parser_config.blade = {
    install_info = {
      url = 'https://github.com/EmranMR/tree-sitter-blade',
      files = { 'src/parser.c' },
      branch = 'main',
    },
    filetype = 'blade',
  }
end, 0)
