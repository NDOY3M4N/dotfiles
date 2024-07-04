-- return {
--   'tpope/vim-dadbod',
--   {
--     'kristijanhusak/vim-dadbod-ui',
--     cmd = {
--        'DBUI',
--     'DBUIToggle',
--     'DBUIAddConnection',
--     'DBUIFindBuffer',
--     },
--     keys = {
--       { '<leader>ri', '<cmd>DBUIToggle<cr>', desc = 'Toggle DBUI' },
--     },
--   },
--   'kristijanhusak/vim-dadbod-completion',
-- }

---@type Lazy
return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  keys = {
    { '<leader>ri', '<cmd>DBUIToggle<cr>', desc = 'Toggle DBUI' },
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}