return {
  {
    'luckasRanarison/tailwind-tools.nvim',
    event = 'VeryLazy',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      server = {
        override = false, -- don't install the LSP using this plugin
      },
    },
  },
}
