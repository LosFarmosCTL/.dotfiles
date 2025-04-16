return {
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    opts = {
      preview = {
        icon_provider = 'devicons',
      },
    },
  },
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup()
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
    cmd = {
      'PeekOpen',
      'PeekClose',
    },
  },
}
