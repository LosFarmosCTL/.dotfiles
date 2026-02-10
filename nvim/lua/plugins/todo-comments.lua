return {
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
    -- stylua: ignore
    keys = require('utils.keymap-helpers').keys {
      ---@diagnostic disable-next-line: undefined-field
      { '<leader>st', function() Snacks.picker.todo_comments() end, desc = '[s]earch [t]odos', icon = { icon = '󰄬', color = 'yellow' } },
    },
  },
}
