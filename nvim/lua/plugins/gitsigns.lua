return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)

      -- stylua: ignore
      Snacks.toggle({
        name = 'Git line [b]lame',
        get = function() return require('gitsigns.config').config.current_line_blame end,
        set = function(_) require('gitsigns').toggle_current_line_blame() end,
      }):map('<leader>ob')
    end,
    -- stylua: ignore
    keys = {
      { ']h', function() if vim.wo.diff then vim.cmd.normal { ']c', bang = true } else require('gitsigns').nav_hunk 'next' end end, },
      { '[h', function() if vim.wo.diff then vim.cmd.normal { '[c', bang = true } else require('gitsigns').nav_hunk 'prev' end end, },

      { '<leader>gs', function() require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = 'git [s]tage hunk', mode = { 'v' }, },
      { '<leader>gr', function() require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = 'git [r]eset hunk', mode = { 'v' }, },

      { '<leader>gs', function() require('gitsigns').stage_hunk() end, desc = 'git [s]tage hunk', },
      { '<leader>gr', function() require('gitsigns').reset_hunk() end, desc = 'git [r]eset hunk', },
      { '<leader>gS', function() require('gitsigns').stage_buffer() end, desc = 'git [S]tage buffer', },
      { '<leader>gR', function() require('gitsigns').reset_buffer() end, desc = 'git [R]eset buffer', },
      { '<leader>gp', function() require('gitsigns').preview_hunk_inline() end, desc = 'git [p]reviw hunk', },
      { '<leader>gb', function() require('gitsigns').blame_line() end, desc = 'git [b]lame line', },
      { '<leader>gd', function() require('gitsigns').diffthis() end, desc = 'git [d]iff against index', },

      { '<leader>ob' }
    },
  },
}
