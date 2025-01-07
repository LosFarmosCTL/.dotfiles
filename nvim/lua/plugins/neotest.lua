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
      local neotest = require 'neotest'

      ---@diagnostic disable-next-line: missing-fields
      neotest.setup {
        adapters = {
          require 'neotest-scala' {
            runner = 'sbt',
            framework = 'scalatest',
          },
          require 'neotest-python',
        },
      }

      vim.keymap.set('n', '<leader>tr', neotest.run.run, { desc = '[T]ests: [R]un' })
      vim.keymap.set('n', '<leader>tf', function()
        neotest.run.run(vim.fn.expand '%')
      end, { desc = '[T]ests: Run [F]ile' })
      vim.keymap.set('n', '<leader>ts', neotest.summary.toggle, { desc = '[T]ests: Show [S]ummary' })
    end,
  },
}
