return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile', 'VeryLazy' },
    lazy = false,
    branch = 'master',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {},
      auto_install = true,
      highlight = { enable = true, disable = { 'dockerfile' } },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
    -- NOTE: not technically a dependency, ensures markview.nvim is loaded before treesitter
    dependencies = { 'OXY2DEV/markview.nvim' },
  },
  {
    'davidmh/mdx.nvim',
    event = { 'BufEnter *.mdx' },
    config = function()
      vim.filetype.add { extension = { mdx = 'mdx' } }

      require('mdx').setup()
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
    -- stylua: ignore
    keys = {
      { '<space>j', function() require('treesj').toggle() end },
    },
  },
}
