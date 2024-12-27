return {
  {
    'github/copilot.vim', -- FIXME: copilot.lua?
    config = function()
      vim.cmd 'Copilot disable'
      vim.keymap.set('i', '<A-j>', '<Plug>(copilot-next)', {})
      vim.keymap.set('i', '<A-k>', '<Plug>(copilot-previous)', {})

      vim.keymap.set('i', '<C-`>', function()
        vim.cmd 'Copilot enable'
        vim.fn['copilot#Suggest']()

        local augroup = vim.api.nvim_create_augroup('copilot', { clear = true })
        vim.api.nvim_create_autocmd('InsertLeave', {
          group = augroup,
          callback = function()
            vim.cmd 'Copilot disable'
            vim.api.nvim_clear_autocmds { group = 'copilot' }
          end,
        })
      end, { desc = 'Trigger Copilot' })
    end,
  },
  -- TODO: copilot chat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    opts = {},
  },
}
