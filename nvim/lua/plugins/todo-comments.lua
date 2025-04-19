return {
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
    -- stylua: ignore
    keys = {
      { '<leader>st', function() Snacks.picker.todo_comments() end, desc = '[s]earch [t]odos', },
    },
  },
}
