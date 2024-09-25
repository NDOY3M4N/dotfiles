vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ignore_install = {},
    modules = {},
    -- NOTE: matchup is not working with treesitter
    pairs = {
      enable = true,
      disable = {},
      highlight_pair_events = {}, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
      highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
      goto_right_end = false, -- whether to go to the end of the right partner or the beginning
      fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
      keymaps = {
        goto_partner = '<leader>%',
        delete_balanced = 'X',
      },
      delete_balanced = {
        only_on_first_char = false, -- whether to trigger balanced delete when on first character of a pair
        fallback_cmd_normal = nil, -- fallback command when no pair found, can be nil
        longest_partner = false, -- whether to delete the longest or the shortest pair when multiple found.
        -- E.g. whether to delete the angle bracket or whole tag in  <pair> </pair>
      },
    },
    ensure_installed = {
      'c',
      'cpp',
      'sql',
      'vimdoc',
      'vim',
      'bash',
      'markdown',
      'markdown_inline',

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
end, 0)
