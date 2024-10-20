require('lazy').setup {
  'tpope/vim-sleuth',
  { 'windwp/nvim-ts-autotag', opts = {} },

  { 'stevearc/dressing.nvim', opts = {} },

  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },

  require 'plugins.gitsigns',

  require 'plugins.which-key',

  require 'plugins.telescope',

  require 'plugins.lspconfig',
  require 'plugins.conform',
  require 'plugins.cmp',

  require 'plugins.tokyonight',

  require 'plugins.todo-comments',

  require 'plugins.mini',

  require 'plugins.treesitter',

  require 'plugins.lint',
}
