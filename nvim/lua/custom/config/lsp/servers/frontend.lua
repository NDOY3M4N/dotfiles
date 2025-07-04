-- NOTE: Options for the typescript plugin for VUEJS
local vue_lsp_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_lsp_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
  enableForWorkspaceTypescriptVersions = true,
}

-- local svelte_lsp_path = vim.fn.stdpath 'data' .. '/mason/packages/svelte-language-server'
-- local svelte_plugin = {
--   name = 'typescript-svelte-plugin',
--   location = svelte_lsp_path,
--   languages = { 'svelte' },
--   configNamespace = 'typescript',
--   enableForWorkspaceTypeScriptVersions = true,
-- }

local M = {}

M.servers = {
  -- NOTE: when the support for HTML super language is there...
  -- biome = {},
  -- emmet_ls = {},
  html = {},
  eslint = {
    filetypes = {
      -- 'json',
      -- 'jsonc',
      -- 'yaml',
      -- 'toml',
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'vue',
      'html',
      'markdown',
      'xml',
      'gql',
      'graphql',
      'astro',
      'svelte',
      'css',
      'less',
      'scss',
      'pcss',
      'postcss',
    },
    settings = {
      -- Silent the stylistic rules in you IDE, but still auto fix them
      rulesCustomizations = {
        { rule = 'style/*', severity = 'off', fixable = true },
        { rule = 'format/*', severity = 'off', fixable = true },
        { rule = '*-indent', severity = 'off', fixable = true },
        { rule = '*-spacing', severity = 'off', fixable = true },
        { rule = '*-spaces', severity = 'off', fixable = true },
        { rule = '*-order', severity = 'off', fixable = true },
        { rule = '*-dangle', severity = 'off', fixable = true },
        { rule = '*-newline', severity = 'off', fixable = true },
        { rule = '*quotes', severity = 'off', fixable = true },
        { rule = '*semi', severity = 'off', fixable = true },
      },
    },
  },
  vtsls = {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte' },
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
    },
  },
  svelte = {},
  vue_ls = {
    on_init = function(client)
      client.handlers['tsserver/request'] = function(_, result, context)
        local clients = vim.lsp.get_clients { bufnr = context.bufnr, name = 'vtsls' }
        if #clients == 0 then
          vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work without it.', vim.log.levels.ERROR)
          return
        end
        local ts_client = clients[1]

        local param = unpack(result)
        local id, command, payload = unpack(param)
        ts_client:exec_cmd({
          title = 'vue_request_forward',
          command = 'typescript.tsserverRequest',
          arguments = { command, payload },
        }, { bufnr = context.bufnr }, function(_, r)
          local response_data = { { id, r.body } }
          ---@diagnostic disable-next-line: param-type-mismatch
          client:notify('tsserver/response', response_data)
        end)
      end
    end,
  },
}

return M
