local M = {}

M.servers = {
  intelephense = {},
  jdtls = {
    cmd = { "jdtls", "-configuration", "/home/p4p1/.cache/jdtls/config", "-data", "/home/p4p1/.cache/jdtls/workspace" }
  },
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
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}

return M
