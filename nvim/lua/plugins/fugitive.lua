return {
  {
    'tpope/vim-fugitive',
    keys = {
      {
        '<leader>gc',
        function()
          vim.ui.input({ prompt = 'Commit message: ' }, function(input)
            if input then
              vim.cmd('Git commit -m "' .. input .. '"')
            end
          end)
        end,
        desc = 'git [c]ommit',
      },
      { '<leader>gB', '<cmd>Git blame<cr>', desc = 'git [B]lame' },
      { '<leader>gl', '<cmd>Git log<cr>', desc = 'git [l]og' },
      { '<leader>gP', '<cmd>Git push<cr>', desc = 'git [P]ush' },
    },
  },
}
