---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'theHamsta/nvim-treesitter-pairs',
  },
  build = ':TSUpdate',
  lazy = false,
  config = function()
    require 'custom.config.treesitter'
  end,
}
