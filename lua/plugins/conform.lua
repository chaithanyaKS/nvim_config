return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  lazy = false,
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true, lsp_format = 'first' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local ignore_filetypes = { 'python' }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return nil
      end
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
      ['*'] = { 'harper-ls' },
      odin = { 'odinfmt' },
      go = { 'goimports' },
    },
  },
}
