return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    vim.keymap.set('n', '<leader>Ha', function()
      harpoon:list():add()
    end, { desc = 'add to harpoon list' })
    vim.keymap.set('n', '<leader>Ht', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'toggle harpoon quick list' })

    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():select(1)
    end, { desc = 'Select 1st item in harpoon list' })
    vim.keymap.set('n', '<C-j>', function()
      harpoon:list():select(2)
    end, { desc = 'Select 2nd item in harpoon list' })
    vim.keymap.set('n', '<C-k>', function()
      harpoon:list():select(3)
    end, { desc = 'Select 3rd item in harpoon list' })
    vim.keymap.set('n', '<C-l>', function()
      harpoon:list():select(4)
    end, { desc = 'Select 4th item in harpoon list' })
    vim.keymap.set('n', '<leader>Hrh', function()
      harpoon:list():replace_at(1)
    end, { desc = 'Replace 1st item in harpoon list' })
    vim.keymap.set('n', '<leader>Hrj', function()
      harpoon:list():replace_at(2)
    end, { desc = 'Replace 2nd item in harpoon list' })
    vim.keymap.set('n', '<leader>Hrk', function()
      harpoon:list():replace_at(3)
    end, { desc = 'Replace 3rd item in harpoon list' })
    vim.keymap.set('n', '<leader>Hrl', function()
      harpoon:list():replace_at(4)
    end, { desc = 'Replace 4th item in harpoon list' })
  end,
}
