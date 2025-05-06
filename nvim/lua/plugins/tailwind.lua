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
    config = function(_, opts)
      require('tailwind-tools').setup(opts)

      -- stylua: ignore
      Snacks.toggle({
        name = '[T]ailwind conceal',
        get = function() return require('tailwind-tools.state').conceal.enabled end,
        set = function(_) require('tailwind-tools.conceal').toggle() end,
      }):map('<leader>ot')
    end,
  },
}
