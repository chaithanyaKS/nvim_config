-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<c-b>', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      always_show = { -- remains visible even if other settings would normally hide it
        '.gitignored',
        '.gitignore',
        '.env',
      },
      window = {
        position = 'right',
        mappings = {
          ['<c-b>'] = 'close_window',
        },
      },
    },
  },
}
