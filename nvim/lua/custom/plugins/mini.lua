---@type LazySpec
return {
  -- Collection of various small independent plugins/modules
  {
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    {
      'echasnovski/mini.ai',
      version = false,
      config = function()
        local spec_treesitter = require('mini.ai').gen_spec.treesitter

        require('mini.ai').setup {
          n_lines = 500,
          custom_textobjects = {
            f = spec_treesitter { a = '@function.outer', i = '@function.inner' },
            o = spec_treesitter {
              a = { '@conditional.outer', '@loop.outer' },
              i = { '@conditional.inner', '@loop.inner' },
            },
          },
        }
      end,
    },

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    { 'echasnovski/mini.surround', version = false, opts = {} },

    -- File explorer (replacement of oil.nvim)
    {
      'echasnovski/mini.files',
      version = false,
      opts = {},
      keys = {
        {
          '<A-e>',
          function()
            local MiniFiles = require 'mini.files'

            if not MiniFiles.close() then
              MiniFiles.open()
            end
          end,
          desc = 'Toggle float for mini.files',
        },
      },
    },
  },
}
