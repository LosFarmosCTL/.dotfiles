-- TODO: toggle to enable/disable
return {
  {
    'b0o/incline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'BufReadPost', 'VeryLazy' },
    opts = {
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local helpers = require 'incline.helpers'
        local devicons = require 'nvim-web-devicons'

        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(bufname, ':t')
        if filename == '' then
          filename = '[No Name]'
        end

        local modified = vim.bo[props.buf].modified
        local bookmarked = require('arrow.statusline').is_on_arrow_file(props.buf)

        local ft_icon, ft_color = devicons.get_icon_color(filename)
        return {
          ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
          ' ',
          { filename, gui = modified and 'bold,italic' or 'bold' },
          ' ',
          bookmarked and { ' ' } or '',
        }
      end,
    },
  },
}
