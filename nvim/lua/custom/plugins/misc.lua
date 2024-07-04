---@type LazySpec
return {
  { -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      local ft = require 'Comment.ft'
      ft.set('typescriptreact', '{/* %s */}')
      ft.set('javascriptreact', '{/* %s */}')
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
