return {
  {
    'folke/trouble.nvim',
    opts = function()
      require('trouble.sources').register('dap', require 'sources.dap')

      return {
        modes = {
          dap_breakpoints = {
            desc = 'DAP Breakpoints',
            mode = 'dap',
            source = 'dap',
            title = '{hl:Title}Breakpoints{hl} {count}',
            -- auto refresh on breakpoint changes using custom event
            events = { 'User DapBreakpointsChanged' },
            groups = {
              { 'filename', format = '{file_icon} {filename} {count}' },
            },
            sort = { 'filename', 'pos' },
            format = '{item.bp_icon} {item.message:Identifier} {text:Comment} {pos}',
            keys = {
              d = {
                action = function(view)
                  local item = view:at()
                  if item and item.buf and item.pos then
                    vim.api.nvim_buf_call(item.buf, function()
                      require('dap.breakpoints').toggle({}, item.buf, item.pos[1])
                    end)

                    view:update()
                  end
                end,
                desc = 'Delete breakpoint',
              },
            },
          },
        },
      }
    end,
    cmd = 'Trouble',
    keys = {
      { '<leader>qd', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
      { '<leader>qD', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
      { '<leader>qs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols' },
      { '<leader>ql', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List' },
      { '<leader>qq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List' },
      { '<leader>qt', '<cmd>Trouble todo toggle focus=true<cr>', desc = 'Todo' },
      { '<leader>qT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}} focus=true<cr>', desc = 'Todo/Fix/Fixme' },
      { '<leader>qb', '<cmd>Trouble dap_breakpoints toggle<cr>', desc = 'Breakpoints' },
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
