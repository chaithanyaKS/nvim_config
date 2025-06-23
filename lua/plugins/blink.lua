return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },

  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    keymap = { preset = 'enter' },

    appearance = {
      nerd_font_variant = 'mono',
      use_nvim_cmp_as_default = false,
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      list = { selection = { auto_insert = false } },
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    cmdline = {
      enabled = false,
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
}
