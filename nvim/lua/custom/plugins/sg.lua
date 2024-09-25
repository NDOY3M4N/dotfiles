return {
  {
    'sourcegraph/sg.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },

    ---@type sg.config
    opts = {
      on_attach = require('utils').on_attach,
      -- chat = {
      --   default_model = 'llma3.1',
      -- },
    },
  },
}
