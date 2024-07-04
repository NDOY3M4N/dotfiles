return {
  {
    'sourcegraph/sg.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },

    opts = {
      on_attach = require('utils').on_attach,
    },
  },
}
