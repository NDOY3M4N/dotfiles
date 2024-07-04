---@type LazySpec
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    -- enabled = false,
    opts = {
      no_italic = true,
      integrations = {
        harpoon = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        diffview = false,
        gitsigns = true,
        markdown = true,
        telescope = true,
        mason = true,
        treesitter = true,
        treesitter_context = true,
      },
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    ---@type Config
    opts = {
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
      on_colors = function(c)
        c.border = c.fg
      end,
    },
    init = function()
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
