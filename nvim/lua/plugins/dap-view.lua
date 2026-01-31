return {
  {
    'igorlfs/nvim-dap-view',
    dependencies = {
      'mfussenegger/nvim-dap',
      'theHamsta/nvim-dap-virtual-text',
    },
    -- stylua: ignore
    keys = {
      { '<leader>dv', function() require('dap-view').toggle() end, desc = '[d]ebug: toggle [v]iew' },
      {
        '<leader>dw',
        function()
          require('dap-view').add_expr()
        end,
        mode = { 'n', 'v' },
        desc = '[d]ebug: add [w]atch expression',
      },
    },
    ---@type dapview.Config
    opts = {
      winbar = {
        default_section = 'breakpoints',
      },
      auto_toggle = true,
    },
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}
