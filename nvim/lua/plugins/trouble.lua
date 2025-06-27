return {
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
      { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List' },
      { '<leader>xt', '<cmd>Trouble todo toggle focus=true<cr>', desc = 'Todo' },
      { '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}} focus=true<cr>', desc = 'Todo/Fix/Fixme' },
    },
    specs = {
      'folke/snacks.nvim',
      opts = function(_, opts)
        return vim.tbl_deep_extend('force', opts or {}, {
          picker = {
            actions = require('trouble.sources.snacks').actions,
            win = {
              input = {
                keys = {
                  ['<c-t>'] = { 'trouble_open', mode = { 'n', 'i' } },
                },
              },
            },
          },
        })
      end,
    },
  },
}
