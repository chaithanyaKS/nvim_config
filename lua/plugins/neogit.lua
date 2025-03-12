return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed.
    'nvim-telescope/telescope.nvim', -- optional
  },

  config = function()
    require('neogit').setup {
      kind = 'vsplit',
      stash = {
        kind = 'vsplit',
      },
    }
    vim.keymap.set('n', '<leader>gs', vim.cmd.Neogit, { desc = '[G]it show' })
  end,
}
