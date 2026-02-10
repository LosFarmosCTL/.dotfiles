return {
  {
    'MagicDuck/grug-far.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'GrugFar',
    keys = require('utils.keymap-helpers').keys {
      {
        '<leader>sr',
        function()
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          require('grug-far').open {
            transient = true,
            prefills = {
              -- automatically filter to current filetype
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n', 'v' },
        desc = '[s]earch and [r]eplace',
        icon = { icon = '󰛔', color = 'green' },
      },
    },
  },
}
