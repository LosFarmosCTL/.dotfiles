return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
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
      { '<leader>ghp', function() require('gitsigns').preview_hunk_inline() end, desc = 'git [h]unk preview', },
      { '<leader>gb', function() require('gitsigns').blame_line() end, desc = 'git [b]lame line', },
      { '<leader>gd', function() require('gitsigns').diffthis() end, desc = 'git [d]iff against index', },
      { '<leader>ob', function() require('gitsigns').toggle_current_line_blame() end, desc = '[T]oggle git show [b]lame line', },
    },
  },
}
