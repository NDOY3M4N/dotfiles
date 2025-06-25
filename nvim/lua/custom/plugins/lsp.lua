---@type LazySpec
return {
  {
    -- NOTE: `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'mason-org/mason.nvim', opts = {} },
      { 'j-hui/fidget.nvim', opts = {} },

      -- Schema information
      'b0o/SchemaStore.nvim',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          require('custom.config.lsp.utils').on_attach(event)
        end,
      })

      -- NOTE: Diagnostic Config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local servers = {
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            json = {
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = require('schemastore').yaml.schemas(),
            },
          },
        },
      }

      local frontend_lsp = require('custom.config.lsp.servers.frontend').servers
      local backend_lsp = require('custom.config.lsp.servers.backend').servers
      servers = vim.tbl_deep_extend('force', servers, frontend_lsp)
      servers = vim.tbl_deep_extend('force', servers, backend_lsp)

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'delve',
        'gofumpt',
        'goimports-reviser',
        'golines',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if pcall(require, 'blink.cmp') then
        capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
      end

      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
      end
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    event = { 'LspAttach', 'BufReadPost', 'BufNewFile' },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- NOTE: Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        -- local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 2500,
          -- lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          lsp_fallback = true,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        php = { 'php_cs_fixer' },
        go = { 'goimports-reviser', 'gofumpt', 'golines' },
      },
    },
  },
}
