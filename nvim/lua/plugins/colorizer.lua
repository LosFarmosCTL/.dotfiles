return {
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = {
        'css',
      },
      user_default_options = {
        css = true,
        css_fn = true,
      },
    },
  },
}
