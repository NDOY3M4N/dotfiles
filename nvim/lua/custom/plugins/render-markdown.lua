---@type LazySpec
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    keys = {
      { '<leader>dm', '<CMD>RenderMarkdown toggle<CR>', desc = 'Toggle Markdown Preview' },
    },
  },
}
