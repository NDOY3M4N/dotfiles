-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local function augroup(group)
  vim.api.nvim_create_augroup('kickstart-' .. group, { clear = true })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup 'highlight-yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Set blade filetype (for Laravel dev)',
  group = augroup 'blade-ft',
  pattern = '*.blade.php',
  command = 'set ft=blade',
})

vim.api.nvim_create_autocmd('Filetype', {
  desc = 'Exit these Filetype with `q` only',
  group = augroup 'quick-exit',
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'checkhealth',
    'netrw',
    'qf',
    'oil',
    'spectre_panel',
    -- 'dbout',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = event.buffer, silent = true })
  end,
})
