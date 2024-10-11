return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- around/inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup()

      require('mini.files').setup()
      vim.keymap.set('n', '<leader>\\', MiniFiles.open, { desc = 'Show file explorer' })

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
      MiniMisc.setup_auto_root {
        'Package.swift',
        'package.js',
        'go.mod',
        'pom.xml',
        '.git',
        'Makefile',
      }
    end,
  },
}
