---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin',
    'letieu/harpoon-lualine',
  },
  config = function()
    local palette = require('tokyonight.colors').setup()

    local projectRoot = function()
      local icon = '%#St_cwd_icon#' .. '󰉋 '
      local name = vim.loop.cwd()

      if name == nil then
        return
      end

      name = '%#St_cwd_text#' .. ' ' .. (name:match '([^/\\]+)[/\\]*$' or name) .. ' '

      return icon .. name
      -- return (vim.o.columns > 85 and ('%#St_cwd_sep#' .. sep_l .. icon .. name)) or ''
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        component_separators = '',
        section_separators = '',
        globalstatus = true,
        theme = 'tokyonight',
      },
      sections = {
        lualine_c = {
          {
            'filetype',
            -- colored = false,
            icon_only = true,
            padding = { left = 1, right = 0 },
            color = { bg = palette.bg_sidebar, fg = palette.fg_sidebar },
          },
          { 'filename', color = { bg = palette.bg_sidebar, fg = palette.fg_sidebar } },
          '%=',
          { 'harpoon2', icon = '󰛢 ' },
        },
        -- TODO: show the LSP server
        lualine_x = {},
        lualine_y = { projectRoot(), 'progress' },
        lualine_z = { 'location' },
      },
      extensions = { 'mason', 'lazy', 'trouble' },
    }
  end,
}
