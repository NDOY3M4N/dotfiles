require 'custom.config.snippets'

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.shortmess:append 'c'

local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup {
  sources = {
    -- { name = 'cody' },
    { name = 'luasnip' },
    { name = 'git' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-y>'] = cmp.mapping.close(),
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-e>'] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { 'i', 'c' }
    ),
  },

  -- Enable luasnip to handle snippet expansion for nvim-cmp
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
      -- NOTE: we can also use native snippet utility (in Neovim 0.10+)
      -- vim.snippet.expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol',
      maxwidth = {
        menu = 50,
        abbr = 50,
      },
      ellipsis_char = '...',
      show_labelDetails = true,
      symbol_map = { Cody = '  ' },
    },
    fields = { 'abbr', 'kind', 'menu' },
    expandable_indicator = true,
  },
  -- experimental = {
  --   ghost_text = true,
  -- },
}

-- Setup up vim-dadbod
cmp.setup.filetype({ 'sql', 'mysql' }, {
  sources = {
    { name = 'vim-dadbod-completion' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
})
