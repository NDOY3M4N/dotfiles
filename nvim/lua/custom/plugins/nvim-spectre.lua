---@type LazySpec
return {
  {
    'nvim-pack/nvim-spectre',
    opts = {},
    keys = {
      { '<leader>f', '<cmd>lua require("spectre").toggle()<cr>', desc = 'Toggle Spectre' },
      { '<leader>fw', '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', desc = 'Search current word' },
    },
  },
}
