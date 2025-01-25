return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {},
      auto_install = true,
      highlight = { enable = true, disable = { 'dockerfile' } },
      indent = { enable = true },
      -- TODO: take a closer look at this
      incremental_selection = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
