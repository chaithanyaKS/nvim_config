return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.icons').setup()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.pairs').setup()
    require('mini.bracketed').setup()
  end,
}
