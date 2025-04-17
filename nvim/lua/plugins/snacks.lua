return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    -- TODO: keybinds for gitbrowse + maybe dim, bufdelete
    opts = {
      bigfile = {},
      dashboard = { example = 'advanced' },
      explorer = {}, -- TODO: keybindings - investigate vs oil.nvim
      -- TODO: Snacks.git.blame_line() ?
      image = {},
      input = {},
      lazygit = {},
      notifier = {},
      -- TODO: `picker` to replace telescope
      quickfile = {},
      -- TODO: `rename` module, depends on what file browser I'll use
      scratch = {}, -- TODO: keymaps for scratch buffers, maybe configure even more quick evals
      statuscolumn = { -- TODO: investigate the entire statuscolumn + signs + folds etc. situation some more
        folds = {
          open = true,
        },
      },
      terminal = {}, -- FIXME: vi mode in fish kinda fucks everything up
      toggle = {},
      words = {},
    },
    -- stylua: ignore
    keys = {
      { '<leader>gg', function() require('snacks').lazygit() end,  desc = 'Show LazyGit'},

      -- jump to next occurence of symbol using `n` if no search is active
      { 'n', function()
          if vim.v.hlsearch == 0 then require('snacks').words.jump(1, true)
          else vim.cmd 'normal! n' end end, },
      { 'N', function()
          if vim.v.hlsearch == 0 then require('snacks').words.jump(-1, true)
          else vim.cmd 'normal! N' end end, },
    },
  },
}
