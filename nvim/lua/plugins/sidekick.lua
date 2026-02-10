return {
  {
    'folke/sidekick.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      cli = {
        win = {
          split = {
            width = 60,
          },
        },
      },
      nes = {
        enabled = false,
      },
    },
    -- stylua: ignore
    keys = require('utils.keymap-helpers').keys {
      {
        '<tab>',
        function() if not require('sidekick').nes_jump_or_apply() then return '<Tab>' end end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      {
        '<c-.>',
        function() require('sidekick.cli').toggle { filter = { installed = true } } end,
        desc = 'Toggle AI CLI',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>aa',
        function() require('sidekick.cli').select { filter = { installed = true } } end,
        desc = 'Attach CLI session',
        icon = { icon = '󰐃', color = 'purple' },
      },
      {
        '<leader>ad',
        function() require('sidekick.cli').close() end,
        desc = 'Detach a CLI Session',
        icon = { icon = '󰐄', color = 'purple' },
      },
      {
        '<leader>at',
        function() require('sidekick.cli').send { msg = '{this}' } end,
        mode = { 'x', 'n' },
        desc = 'Send [t]his to CLI',
        icon = { icon = '󰜴', color = 'purple' },
      },
      {
        '<leader>af',
        function() require('sidekick.cli').send { msg = '{file}' } end,
        desc = 'Send [f]ile to CLI',
        icon = { icon = '󰈙', color = 'purple' },
      },
      {
        '<leader>av',
        function() require('sidekick.cli').send { msg = '{selection}' } end,
        mode = { 'x' },
        desc = 'Send [v]isual selection to CLI',
        icon = { icon = '󰆏', color = 'purple' },
      },
      {
        '<leader>ap',
        function() require('sidekick.cli').prompt() end,
        mode = { 'n', 'x' },
        desc = 'Send [p]rompt to CLI',
        icon = { icon = '󰍩', color = 'purple' },
      },
    },
  },
}
