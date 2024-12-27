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

      require('mini.notify').setup {
        lsp_progress = {
          enable = false,
        },
      }

      local mini_notify = require('mini.notify').make_notify()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.notify = function(msg, level, _)
        if level == 'warn' then
          level = 3
        elseif level == 'error' then
          level = 4
        end

        mini_notify(msg, level)
      end
    end,
  },
}
