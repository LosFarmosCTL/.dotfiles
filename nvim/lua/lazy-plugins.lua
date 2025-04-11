require('lazy').setup {
  'tpope/vim-sleuth',

  { 'stevearc/dressing.nvim', opts = {} },

  -- { 'brenoprata10/nvim-highlight-colors', opts = {} }, brenoprata10/nvim-highlight-colors#126

  require 'plugins.gitsigns',

  require 'plugins.which-key',

  require 'plugins.telescope',

  require 'plugins.lspconfig',
  require 'plugins.conform',
  require 'plugins.cmp',
  require 'plugins.autopairs',

  require 'plugins.neotest',

  require 'plugins.copilot',

  require 'plugins.tokyonight',

  require 'plugins.todo-comments',

  require 'plugins.mini',

  require 'plugins.treesitter',

  require 'plugins.lint',

  require 'plugins.peek',
}
