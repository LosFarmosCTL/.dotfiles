return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      -- transparent = true,
      on_colors = function(colors)
        colors.bg = '#1e1e1e'
        colors.bg_dark = '#161616'
        colors.bg_float = '#161616'
        colors.bg_popup = '#161616'
        colors.bg_sidebar = '#161616'
        colors.bg_statusline = '#161616'
        colors.bg_highlight = '#282828'
      end,
    },
  },
}
