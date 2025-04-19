return {
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      user_default_options = {
        css = true,
        css_fn = true,
        tailwind = 'both',
        tailwind_opts = {
          update_names = true,
        },
      },
    },
  },
}
