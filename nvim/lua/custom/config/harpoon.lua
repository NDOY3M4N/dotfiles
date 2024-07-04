local harpoon = require 'harpoon'
harpoon:setup {}

vim.keymap.set('n', '<leader>ma', function()
  harpoon:list():add()
end, { desc = '[A]dd buffer to Harpoon' })

vim.keymap.set('n', '<leader>mm', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Toggle Harpoon' })

for _, idx in ipairs { 1, 2, 3, 4 } do
  vim.keymap.set('n', string.format('<A-%d>', idx), function()
    harpoon:list():select(idx)
  end, { desc = string.format('Select Item #%d', idx) })
end
