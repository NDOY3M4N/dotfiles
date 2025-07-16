-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Disable Space bar since it's used as leader key
vim.keymap.set('n', '<Space>', '<Nop>', { desc = 'Disable Space bar' })

-- Source files
vim.keymap.set('n', '<Space><Space>p', '<CMD>source %<CR>', { desc = 'source current buffer' })
vim.keymap.set('n', '<Space>p', ':.lua<CR>', { desc = 'source current line' })
vim.keymap.set('v', '<Space>p', ':lua<CR>', { desc = 'source current selection' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quickly enter Normal mode
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Enter normal mode' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Enter normal mode' })

-- Stay in indent mode
vim.keymap.set('v', '>', '>gv', { desc = 'Stay in indent mode' })
vim.keymap.set('v', '<', '<gv', { desc = 'Stay in indent mode' })

-- Move lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Ctrl-s to save file
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save current file' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>dd', function()
  -- TODO: refactor this
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    vim.notify('Diagnostics disabled', vim.log.levels.INFO, { title = 'Diagnostics' })
  else
    vim.diagnostic.enable()
    vim.notify('Diagnostics enabled', vim.log.levels.INFO, { title = 'Diagnostics' })
  end
end, { desc = 'Toggle diagnostics' })

-- Buffers
vim.keymap.set('n', '<A-h>', '<cmd>bprev<cr>', { desc = 'Go to the previous buffer' })
vim.keymap.set('n', '<A-l>', '<cmd>bnext!<cr>', { desc = 'Go to the next buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>bdel<cr>', { desc = 'Delete current buffer' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
