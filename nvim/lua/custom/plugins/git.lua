---@type LazySpec
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '󰍵' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '│' },
      },
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'sindrets/diffview.nvim', -- Diff integration
      -- 'ibhagwan/fzf-lua', -- optional
    },
    config = true,
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Start Neogit' },
    },
  },
}
