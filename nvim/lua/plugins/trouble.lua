return {
  {
    'folke/trouble.nvim',
    dependencies = {
      'folke/todo-comments.nvim',
    },
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
    keys = require('utils.keymap-helpers').keys {
      { '<leader>qd', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics', icon = { icon = '󰔫', color = 'red' } },
      { '<leader>qD', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics', icon = { icon = '󰔫', color = 'red' } },
      { '<leader>qs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols', icon = { icon = '󰏢', color = 'cyan' } },
      { '<leader>ql', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List', icon = { icon = '󰉸', color = 'blue' } },
      { '<leader>qq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List', icon = { icon = '󰉸', color = 'blue' } },
      { '<leader>qt', '<cmd>Trouble todo toggle focus=true<cr>', desc = 'Todo', icon = { icon = '󰄬', color = 'yellow' } },
      { '<leader>qb', '<cmd>Trouble dap_breakpoints toggle<cr>', desc = 'Breakpoints', icon = { icon = '󰃤', color = 'red' } },
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
