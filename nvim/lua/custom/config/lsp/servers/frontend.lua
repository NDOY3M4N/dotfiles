-- NOTE: Options for the typescript plugin for VUEJS
local vue_lsp_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_lsp_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
  enableForWorkspaceTypescriptVersions = true,
}

local svelte_lsp_path = vim.fn.stdpath 'data' .. '/mason/packages/svelte-language-server'
local svelte_plugin = {
  name = 'typescript-svelte-plugin',
  location = svelte_lsp_path,
  languages = { 'svelte' },
  configNamespace = 'typescript',
  enableForWorkspaceTypeScriptVersions = true,
}

local M = {}

M.servers = {
  -- NOTE: when the support for HTML super language is there...
  -- biome = {},
  -- emmet_ls = {},
  html = {},
  eslint = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'vue',
      'html',
      'markdown',
      'json',
      'jsonc',
      'yaml',
      'toml',
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
      javascript = {
        -- preferences = {
        --   importModuleSpecifier = "non-relative",
        -- },
        inlayHints = {
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = 'all' },
          variableTypes = { enabled = true },
        },
      },
      typescript = {
        inlayHints = {
          parameterNames = { enabled = 'all' },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
        },
      },
      vtsls = {
        autoUserWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
            entriesLimit = 50,
          },
        },
        tsserver = {
          preferences = {
            includeInlayFunctionLikeReturnTypeHints = false,
          },
          globalPlugins = { vue_plugin, svelte_plugin },
        },
      },
    },
  },
  svelte = {},
  vue_ls = {},
}

return M
