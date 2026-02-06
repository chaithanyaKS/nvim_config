return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependents
    { 'williamboman/mason-lspconfig.nvim', version = '*' },
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        vim.keymap.set('i', '<c-k>', function()
          return vim.lsp.buf.signature_help()
        end, { buffer = event.buf, desc = 'LSP: Signature Help' })

        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>td', function()
          local config = vim.diagnostic.config() or {}
          local virtual_text = not config.virtual_text
          vim.diagnostic.config { virtual_text = virtual_text }
        end, '[T]oggle [D]iagnostic Virtual text')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local blink_capabilities = require('blink-cmp').get_lsp_capabilities()

    capabilities = vim.tbl_deep_extend('force', capabilities, blink_capabilities)

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
      basedpyright = {
        settings = {
          basedpyright = {
            typeCheckingMode = 'standard',
            reportMissingParameterType = false,
          },
        },
      },
      ols = {
        settings = {
          checker_args = '-strict-style',
        },
      },
      zls = {
        settings = {
          autocompleteFunctionParams = false,
        },
      },
    }

    require('mason').setup()
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
      'gopls',
      'goimports',
      'basedpyright',
      'harper-ls',
      'ruff',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          if server_name == 'jdtls' then
            require('lspconfig').jdtls.setup {
              cmd = { 'echo', 'disabled' },
              on_attach = function()
                return
              end,
            }
          else
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end
        end,
      },
    }
  end,
}
