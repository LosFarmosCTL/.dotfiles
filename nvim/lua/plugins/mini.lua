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

      local statusline = require 'mini.statusline'
      statusline.setup()
      -- display cursor position in statusline as LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.misc').setup()
    end,
    -- stylua: ignore
    keys = {
      { '<leader>\\', function() require('mini.files').open() end, desc = 'Show file explorer', }, 
    },
  },
}
