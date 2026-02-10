return {
  {
    'tpope/vim-fugitive',
    keys = require('utils.keymap-helpers').keys {
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
        icon = { icon = '', color = 'orange' },
      },
      { '<leader>gB', '<cmd>Git blame<cr>', desc = 'git [B]lame', icon = { icon = '󰀈', color = 'orange' } },
      { '<leader>gl', '<cmd>Git log<cr>', desc = 'git [l]og', icon = { icon = '󰋚', color = 'orange' } },
      { '<leader>gP', '<cmd>Git push<cr>', desc = 'git [P]ush', icon = { icon = '', color = 'orange' } },
    },
  },
}
