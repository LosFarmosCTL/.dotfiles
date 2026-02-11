return {
  {
    'otavioschwanck/arrow.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      show_icons = true,
      leader_key = ':',
      separate_by_branch = true,
      separate_save_and_remove = true,
      window = {
        border = 'rounded',
      },
    },
    -- stylua: ignore
    keys = require('utils.keymap-helpers').keys {
      { ':', desc = 'Open Arrow bookmarks' },
      { 'H', function() require('arrow.persist').previous() end, desc = 'Previous Arrow bookmark' },
      { 'L', function() require('arrow.persist').next() end, desc = 'Next Arrow bookmark' },
      { '<leader>m', function() require('arrow.persist').toggle() end, desc = '[M]ark buffer in arrow.nvim', icon = { icon = '󰃃', color = 'yellow' } },
    },
  },
}
