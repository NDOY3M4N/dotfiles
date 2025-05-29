return {
  -- Display colors
  {
    'catgoose/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {
      lazy_load = true,
      filetypes = {
        css = { hsl_fn = true },
        html = { mode = 'foreground' },
        'javascript',
      },
      user_default_options = {
        names = false,
        tailwind = 'both',
      },
    },
  },
}
