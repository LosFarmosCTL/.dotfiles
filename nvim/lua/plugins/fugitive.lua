return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    keys = {
      { '<leader>gc', '<cmd>Git commit<cr>', desc = 'git [c]ommit' },
      { '<leader>gB', '<cmd>Git blame<cr>', desc = 'git [B]lame' },
      { '<leader>gl', '<cmd>Git log<cr>', desc = 'git [l]og' },
    },
  },
}
