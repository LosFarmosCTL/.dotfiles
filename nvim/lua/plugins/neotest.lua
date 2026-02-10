return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'stevanmilic/neotest-scala',
      'nvim-neotest/neotest-python',

      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').setup {
        adapters = {
          require 'neotest-scala' {
            runner = 'sbt',
            framework = 'scalatest',
          },
          require 'neotest-python',
        },
      }
    end,
    -- stylua: ignore
    keys = require('utils.keymap-helpers').keys {
      { '<leader>tr', function() require('neotest').run.run() end, desc = '[T]ests: [r]un nearest', icon = { icon = '󰙨', color = 'cyan' } },
      { '<leader>tR', function() require('neotest').run.run(vim.fn.expand '%') end, desc = '[T]ests: [Run] file', icon = { icon = '󰙨', color = 'cyan' } },
---@diagnostic disable-next-line: missing-fields
      { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = '[T]ests: [d]ebug nearest', icon = { icon = '󰃤', color = 'cyan' } },
      { '<leader>tl', function() require('neotest').run.run_last() end, desc = '[T]ests: [l]ast run', icon = { icon = '󰙨', color = 'cyan' } },
      { '<leader>to', function() require('neotest').output.open { enter = true, auto_close = true } end, desc = '[T]ests: show [o]utput', icon = { icon = '󰅍', color = 'cyan' } },
      { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = '[T]ests: [O]utput panel', icon = { icon = '󰯂', color = 'cyan' } },
      { '<leader>ts', function() require('neotest').summary.toggle() end, desc = '[T]ests: Show [s]ummary', icon = { icon = '󰦨', color = 'cyan' } },
    },
  },
}
