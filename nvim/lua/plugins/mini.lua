return {
  {
    'echasnovski/mini.nvim',
    lazy = false,
    config = function()
      -- around/inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup()

      -- square bracket navigation
      require('mini.bracketed').setup()
    end,
  },
}
