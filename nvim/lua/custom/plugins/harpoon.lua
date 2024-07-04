---@type LazySpec
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    -- vim.keymap.set()

    local nmap = function(keys, func, desc)
      if desc then
        desc = 'Harpoon: ' .. desc
      end

      vim.keymap.set('n', keys, func, { desc = desc })
    end

    nmap('<leader>ma', function()
      harpoon:list():add()
    end, 'Append')
    nmap('<leader>mm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, 'Toggle menu')

    nmap('<A-p>', function()
      harpoon:list():prev()
    end, 'select previous item')
    nmap('<A-n>', function()
      harpoon:list():next()
    end, 'select next item')
    nmap('<A-1>', function()
      harpoon:list():select(1)
    end, 'select item #1')
    nmap('<A-2>', function()
      harpoon:list():select(2)
    end, 'select item #2')
    nmap('<A-3>', function()
      harpoon:list():select(3)
    end, 'select item #3')
    nmap('<A-4>', function()
      harpoon:list():select(4)
    end, 'select item #4')
  end,
}
