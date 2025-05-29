---@type LazySpec
return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} },

      -- Schema information
      'b0o/SchemaStore.nvim',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          require('utils').on_attach(_, event.buf)

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = nil
      if pcall(require, 'cmp_nvim_lsp') then
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      end

      -- Enable the following language servers
      local mason_registry = require 'mason-registry'
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

      -- NOTE: for denols
      vim.g.markdown_fenced_languages = {
        'ts=typescript',
      }

      local servers = {
        -- NOTE: when the support for HTML super language is there...
        -- biome = {},
        -- eslint = {},
        -- emmet_ls = {},
        html = {},
        ts_ls = {
          -- root_dir = function()
          --   if vim.fs.root(0, { 'deno.json', 'deno.jsonc' }) then
          --     return nil
          --   end
          --
          --   return vim.fs.root(0, { 'tsconfig.json', 'jsconfig.json', 'package.json' })
          -- end,
          root_dir = require('lspconfig').util.root_pattern 'package.json',
          init_options = {
            preferences = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
              importModuleSpecifierPreference = 'non-relative',
            },
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
              },
            },
          },
          single_file_support = false,
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        },
        denols = {
          enable = false,
          root_dir = require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc'),
          init_options = {
            lint = true,
            suggest = {
              imports = {
                hosts = {
                  ['https://deno.land'] = true,
                },
              },
            },
          },
        },

        volar = {},
        svelte = {},
        intelephense = {},
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
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
        -- require 'custom.config.lsp.lua_ls',
        lua_ls = require 'custom.config.lsp.lua_ls',
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    event = { 'LspAttach', 'BufReadPost', 'BufNewFile' },
    -- keys = {
    --   {
    --     '<leader>f',
    --     function()
    --       require('conform').format { async = true, lsp_fallback = true }
    --     end,
    --     mode = '',
    --     desc = '[F]ormat buffer',
    --   },
    -- },
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
        go = { 'goimports-reviser', 'gofumpt', 'golines' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        svelte = { 'prettierd' },
        vue = { 'prettierd' },
        lua = { 'stylua' },
        php = { 'php_cs_fixer' },
      },
    },
  },
}
