return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        disabled_filetypes = { 'snacks_dashboard' },
        ignore_focus = { 'TelescopePrompt' },
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
            symbols = {
              modified = ' ●',
              readonly = ' ',
            },
          },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype', {
          'lsp_status',
          icon = ' ',
          ignore_lsp = { 'copilot' },
        } },
      },
    },
  },
}
