return {
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      view = {
        merge_tool = {
          layout = 'diff4_mixed',
        },
      },
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_win_enter = function(bufnr, winid, ctx)
          -- turn off cursorline for diff buffers
          -- https://github.com/neovim/neovim/issues/9800
          vim.wo[winid].culopt = 'number'

          -- disable line wrapping for diff buffers
          vim.wo[winid].wrap = false

          vim.api.nvim_set_hl(0, 'DiffviewDiffDeleteDim', { link = 'DiagnosticUnnecessary' })
        end,
      },
    },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'git [d]iff against index' },
    },
  },
}
