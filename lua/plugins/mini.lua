return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.icons').setup()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.bracketed').setup()
    require('mini.pairs').setup {
      -- In which modes mappings from this `config` should be created
      modes = { insert = true, command = false, terminal = false },
      mappings = {
        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
        ['['] = {
          action = 'open',
          pair = '[]',
          neigh_pattern = '.[%s%z%)}%]]',
          register = { cr = false },
        },
        ['{'] = {
          action = 'open',
          pair = '{}',
          neigh_pattern = '.[%s%z%)}%]]',
          register = { cr = false },
        },
        ['('] = {
          action = 'open',
          pair = '()',
          neigh_pattern = '.[%s%z%)]',
          register = { cr = false },
        },
        ['"'] = {
          action = 'closeopen',
          pair = '""',
          neigh_pattern = '[^%w\\][^%w]',
          register = { cr = false },
        },
        ["'"] = {
          action = 'closeopen',
          pair = "''",
          neigh_pattern = '[^%w\\][^%w]',
          register = { cr = false },
        },
        ['`'] = {
          action = 'closeopen',
          pair = '``',
          neigh_pattern = '[^%w\\][^%w]',
          register = { cr = false },
        },
      },
    }
  end,
}
