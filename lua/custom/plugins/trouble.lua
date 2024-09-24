return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup {
        -- icons = false,
      }

      vim.keymap.set('n', '<leader>tt', function()
        require('trouble').toggle { desc = 'Toggle Trouble list' }
      end)

      vim.keymap.set('n', '[t', function()
        require('trouble').next { skip_groups = true, jump = true }
      end, { desc = 'got to next item in trouble list' })

      vim.keymap.set('n', ']t', function()
        require('trouble').previous { skip_groups = true, jump = true }
      end, { desc = 'go to previous item in trouble list' })
    end,
  },
}
