return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        swift = { 'swiftlint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        pattern = '{*}{*.swiftinterface}\\@<!', -- disable LSP-generated swiftinterface files
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
