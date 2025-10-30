return {
  'ravitemer/mcphub.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
  config = function()
    require('mcphub').setup {
      native_servers = {
        redis = require 'redis_server',
        mysql = require 'mcphub.mysql_server',
      },
    }
  end,
}
