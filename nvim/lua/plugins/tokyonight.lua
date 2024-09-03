return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
}
