---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      'andymass/vim-matchup',
      event = 'CursorMoved',
      config = function()
        vim.g.matchup_matchparen_offscreen = { method = 'popup' }
      end,
    },
  },
  build = ':TSUpdate',
  lazy = false,
  config = function()
    require 'custom.config.treesitter'
  end,
}
