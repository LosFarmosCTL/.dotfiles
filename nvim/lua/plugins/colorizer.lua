return {
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = {
        'css',
      },
      options = {
        parsers = {
          css = true,
          css_fn = true,
        },
        -- display = {
        --   mode = 'virtualtext',
        --   virtualtext = {
        --     position = 'before',
        --   },
        -- },
      },
    },
  },
}
