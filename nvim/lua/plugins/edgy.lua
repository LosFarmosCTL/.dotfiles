return {
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    opts = {
      animate = {
        enabled = false,
      },
      bottom = {
        {
          ft = 'help',
          size = { height = 20 },
          -- don't open help files in edgy that are being edited
          filter = function(buf)
            return vim.bo[buf].buftype == 'help'
          end,
        },
      },
      left = {
        { title = 'Neotest Summary', ft = 'neotest-summary' },
      },
      right = {
        {
          ft = 'grug-far',
          size = { width = 0.3 },
          title = 'Search & Replace',
        },
      },
    },
  },
}
