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
        { '<leader>c', group = '[C]ode' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>g', group = '[G]it' },
        { '<leader>l', group = '[L]sp' },
        { '<leader>o', group = '[O]ptions' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>x', group = 'Trouble' },
      }
    end,
  },
}
