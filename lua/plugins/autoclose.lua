return {
  'm4xshen/autoclose.nvim',
  event = 'VimEnter',
  config = function()
    require('autoclose').setup {
      options = {
        disable_when_touch = true,
      },
    }
  end,
}
