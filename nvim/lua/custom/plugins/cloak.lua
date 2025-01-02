---@type LazySpec
return {
  -- Hide env variables
  {
    'laytan/cloak.nvim',
    config = function()
      require('cloak').setup {
        cloak_telescope = false,
      }

      vim.keymap.set('n', '<leader>vv', '<cmd>CloakToggle<cr>', { desc = 'Toggle cloak' })
    end,
  },
}
