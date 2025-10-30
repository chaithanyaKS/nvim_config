return {
  'zbirenbaum/copilot.lua',
  requires = {
    'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
  },
  dependencies = {
    'giuxtaposition/blink-cmp-copilot',
  },
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
  end,
}
-- return {
--   {
--     'CopilotC-Nvim/CopilotChat.nvim',
--     dependencies = {
--       { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
--       { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
--     },
--     build = 'make tiktoken',
--     opts = {
--       -- See Configuration section for options
--     },
--     -- See Commands section for default commands if you want to lazy load on them
--   },
-- }
