---@type LazySpec
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ---@module "render-markdown"
    opts = {
      file_types = { 'markdown', 'Avante' },
      heading = { width = 'block' },
    },
    ft = { 'markdown', 'Avante' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    keys = {
      { '<leader>dm', '<CMD>RenderMarkdown toggle<CR>', desc = 'Toggle Markdown Preview' },
    },
  },
}
