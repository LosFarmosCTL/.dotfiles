return {
  {
    'echasnovski/mini.nvim',
    lazy = false,
    config = function()
      -- around/inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup()

      require('mini.files').setup()

      -- square bracket navigation
      require('mini.bracketed').setup()

      require('mini.misc').setup()
    end,
    -- stylua: ignore
    keys = {
      { '<leader>\\', function() require('mini.files').open() end, desc = 'Show file explorer', }, 
    },
  },
}
