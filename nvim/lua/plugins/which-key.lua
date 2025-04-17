return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require 'which-key'
      ---@diagnostic disable-next-line: missing-fields
      wk.setup {
        preset = 'helix',
      }

      wk.add {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>g', group = '[G]it' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>o', group = '[O]ptions' },
        { '<leader>c', group = '[C]ode' },
      }
    end,
  },
}
