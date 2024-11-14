require('lazy').setup {
  'tpope/vim-sleuth',
  { 'windwp/nvim-ts-autotag', opts = {} },

  { 'stevearc/dressing.nvim', opts = {} },

  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { map_bs = false } },

  { 'brenoprata10/nvim-highlight-colors', opts = {} },

  require 'plugins.gitsigns',

  require 'plugins.which-key',

  require 'plugins.telescope',

  require 'plugins.lspconfig',
  require 'plugins.conform',
  require 'plugins.cmp',

  require 'plugins.copilot',

  require 'plugins.tokyonight',

  require 'plugins.todo-comments',

  require 'plugins.mini',

  require 'plugins.treesitter',

  require 'plugins.lint',

  require 'plugins.peek',
}
