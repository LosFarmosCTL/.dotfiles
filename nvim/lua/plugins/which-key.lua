return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require 'which-key'
      ---@diagnostic disable-next-line: missing-fields
      wk.setup { preset = 'helix' }

      -- TODO: look into setting icons for keymaps
      wk.add {
        { '<leader>a', group = '[A]I' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>g', group = '[G]it' },
        { '<leader>l', group = '[L]sp' },
        { '<leader>o', group = '[O]ptions' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>q', group = 'Trouble' },
        { '<leader>j', group = 'Swap with next...' },
        { '<leader>k', group = 'Swap with previous...' },
        { '<leader>x', group = '[X]Code' },
        { '<leader>xc', group = '[C]lean' },
        { '<leader><tab>', group = 'Tabs' },
      }
    end,
  },
}
