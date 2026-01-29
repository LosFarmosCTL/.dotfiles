return {
  {
    'gbprod/yanky.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = { 'folke/snacks.nvim' },
    opts = {
      textobj = {
        enabled = true,
      },
    },
    keys = {
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },

      { '<C-p>', '<Plug>(YankyPreviousEntry)', desc = 'Select previous entry through yank history' },
      { '<C-n>', '<Plug>(YankyNextEntry)', desc = 'Select next entry through yank history' },

      {
        '<leader>p',
        function()
          ---@diagnostic disable-next-line: undefined-field
          require('snacks').picker.yanky()
        end,
        mode = { 'n', 'x' },
        desc = 'Open yank history',
      },

      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },

      { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put after applying a filter' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put before applying a filter' },
    },
    config = function(_, opts)
      require('yanky').setup(opts)

      vim.keymap.set({ 'o', 'x' }, 'iy', function()
        require('yanky.textobj').last_put()
      end, { desc = 'Last put text' })
    end,
  },
}
