---@type LazySpec
return {
  { -- LSP completions
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      { -- Snippet Engine
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = 'make install_jsregexp',
        opts = {},
      },
      'folke/lazydev.nvim',
      'Kaiser-Yang/blink-cmp-git',
      'kristijanhusak/vim-dadbod-completion',
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-y>'] = { 'hide' },
        ['<C-e>'] = { 'select_and_accept' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        per_filetype = {
          gitcommit = { 'git' },
          sql = { 'snippets', 'dadbod', 'buffer' },
        },
        providers = {
          git = { module = 'blink-cmp-git' },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },
}
