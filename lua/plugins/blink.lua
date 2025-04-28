return {
  'saghen/blink.cmp',
  version = '1.*',
  opts_extend = {
    'sources.completion.enabled_providers',
    'sources.default',
  },

  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  event = 'InsertEnter',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    appearance = {
      nerd_font_variant = 'mono',
      use_nvim_cmp_as_default = false,
    },

    completion = {
      accept = {
        auto_brackets = { enabled = false },
      },
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },

      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      list = { selection = { auto_insert = false, preselect = false } },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    cmdline = {
      enabled = false,
    },

    keymap = { preset = 'default' },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
}
