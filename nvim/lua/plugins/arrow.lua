return {
  {
    'otavioschwanck/arrow.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      show_icons = true,
      leader_key = ':',
      buffer_leader_key = 'gm',
      separate_by_branch = true,
      separate_save_and_remove = true,
      window = {
        border = 'rounded',
      },
    },
    -- stylua: ignore
    keys = require('utils.keymap-helpers').keys {
      { ':', desc = 'Open Arrow bookmarks' },
      { 'gm', desc = 'Open buffer bookmarks (Arrow)', mode = 'n' },
      { '[a', function() require('arrow.persist').previous() end, desc = 'Previous Arrow bookmark' },
      { ']a', function() require('arrow.persist').next() end, desc = 'Next Arrow bookmark' },
      { '<leader>bm', function() require('arrow.persist').toggle() end, desc = '[b]uffer [m]ark in arrow.nvim', icon = { icon = '󰃃', color = 'yellow' } },
    },
  },
}
