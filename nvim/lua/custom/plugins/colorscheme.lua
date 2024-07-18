---@type LazySpec
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
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
      -- vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    ---@type tokyonight.Config
    opts = {
      style = 'moon',
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
      on_colors = function(c)
        c.border = c.border
      end,
    },
    init = function()
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
