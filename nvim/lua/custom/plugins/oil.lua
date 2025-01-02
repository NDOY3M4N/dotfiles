---@type LazySpec
return {
  'stevearc/oil.nvim',
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    view_options = { show_hidden = true },
    keymaps = {
      ['<C-x>'] = { 'actions.select', opts = { horizontal = true } },
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    },
  },
  keys = {
    {
      '<A-e>',
      function()
        require('oil').toggle_float()
      end,
      desc = 'Toggle float for oil.nvim',
    },
  },
}
