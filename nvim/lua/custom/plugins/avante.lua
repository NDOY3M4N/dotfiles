return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    enabled = false,
    version = false,
    opts = {
      providers = {
        gemini = {
          endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
          model = 'gemini-2.0-flash',
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          max_tokens = 8192,
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },
}
