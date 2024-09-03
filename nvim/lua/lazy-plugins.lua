require('lazy').setup {
  'tpope/vim-sleuth',

  { 'stevearc/dressing.nvim', opts = {} },

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

  -- TODO: add debugging and linting stuff
}
