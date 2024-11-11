---@type LazySpec
return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    lazy = false,
    priority = 100,
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'petertriho/cmp-git',
      'onsails/lspkind.nvim',
      -- Snippet Engine & its associated nvim-cmp source
      { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
    },
    config = function()
      require 'custom.config.completions'
    end,
  },
}
