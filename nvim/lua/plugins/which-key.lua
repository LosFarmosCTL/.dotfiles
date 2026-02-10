return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require 'which-key'
      ---@diagnostic disable-next-line: missing-fields
      wk.setup { preset = 'helix' }

      wk.add {
        { '<leader>a', mode = { 'n', 'x' }, group = '[A]I', icon = { icon = '󰧑', color = 'purple' } },
        { '<leader>b', group = '[B]uffer', icon = { icon = '󰈙', color = 'blue' } },
        { '<leader>c', mode = { 'n', 'x' }, group = '[C]ode', icon = { icon = '󰅩', color = 'cyan' } },
        { '<leader>d', mode = { 'n', 'x' }, group = '[D]ebug', icon = { icon = '󰃤', color = 'red' } },
        { '<leader>f', group = '[F]ind', icon = { icon = '󰍉', color = 'yellow' } },
        { '<leader>g', mode = { 'n', 'x' }, group = '[G]it', icon = { icon = '󰊢', color = 'orange' } },
        { '<leader>l', group = '[L]sp', icon = { icon = '󰒕', color = 'azure' } },
        { '<leader>o', group = '[O]ptions', icon = { icon = '󰒓', color = 'grey' } },
        { '<leader>s', mode = { 'n', 'x' }, group = '[S]earch', icon = { icon = '󰑑', color = 'green' } },
        { '<leader>t', group = '[T]est', icon = { icon = '󰙨', color = 'cyan' } },
        { '<leader>q', group = 'Trouble', icon = { icon = '󰔫', color = 'red' } },
        { '<leader>j', group = 'Swap with next...', icon = { icon = '', color = 'azure' } },
        { '<leader>k', group = 'Swap with previous...', icon = { icon = '', color = 'azure' } },
        { '<leader>x', group = '[X]Code', icon = { icon = '󰀴', color = 'purple' } },
        { '<leader>xc', group = '[C]lean', icon = { icon = '󰃢', color = 'green' } },
        { '<leader><tab>', group = 'Tabs', icon = { icon = '󰓩', color = 'yellow' } },
      }

      require('utils.keymap-registry').flush()
    end,
  },
}
