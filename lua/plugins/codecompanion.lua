return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ravitemer/mcphub.nvim',
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
    'j-hui/fidget.nvim',
  },
  opts = {
    strategies = {
      chat = {
        name = 'copilot',
        model = 'claude-sonnet-4.5',
        completion_provider = 'blink',
      },
      inline = {
        adapter = 'copilot',
      },
      cmd = {
        adapter = 'copilot',
      },
    },
    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          -- MCP Tools
          make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true, -- Show tool results directly in chat buffer
          format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true, -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true, -- Add MCP prompts as /slash commands
        },
      },
      spinner = {},
    },
    memory = {
      opts = {
        chat = {
          enabled = true,
          default_memory = { 'default' },
        },
      },
    },
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = 'Prompt ', -- Prompt used for interactive LLM calls
        provider = 'default', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          title = 'CodeCompanion actions', -- The title of the action palette
        },
      },
      chat = {
        intro_message = 'Welcome to CodeCompanion ✨! Press ? for options',
        separator = '─', -- The separator between the different messages in the chat buffer
        show_context = true, -- Show context (from slash commands and variables) in the chat buffer?
        show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
        show_settings = false, -- Show LLM settings at the top of the chat buffer?
        show_token_count = true, -- Show the token count for each response?
        show_tools_processing = true, -- Show the loading message when tools are being executed?
        start_in_insert_mode = false, -- Open the chat buffer in insert mode?
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = 'DEBUG',
    },
  },

  config = function()
    require('codecompanion').setup {}
    local progress = require 'fidget.progress'
    local handles = {}
    local group = vim.api.nvim_create_augroup('CodeCompanionFidget', {})

    vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionRequestStarted',
      group = group,
      callback = function(e)
        handles[e.data.id] = progress.handle.create {
          title = 'CodeCompanion',
          message = 'Thinking...',
          lsp_client = { name = e.data.adapter.formatted_name },
        }
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionRequestFinished',
      group = group,
      callback = function(e)
        local h = handles[e.data.id]
        if h then
          h.message = e.data.status == 'success' and 'Done' or 'Finished'
          h:finish()
          handles[e.data.id] = nil
        end
      end,
    })
  end,
}
