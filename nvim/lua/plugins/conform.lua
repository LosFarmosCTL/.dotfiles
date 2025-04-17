return {
  {
    'stevearc/conform.nvim',
    event = { 'VeryLazy' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat then
          return
        else
          -- disable LSP formatting fallback for specific languages
          local disable_filetypes = { c = true, cpp = true }
          return {
            timeout_ms = 500,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          }
        end
      end,
      formatters_by_ft = {
        swift = { 'swift-format' },
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_fix' },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
    config = function(_, opts)
      require('conform').setup(opts)

      -- stylua: ignore
      Snacks.toggle({
        name = 'Auto[f]ormat on save',
        get = function() return not vim.g.disable_autoformat end,
        set = function(state)
          if state then vim.g.disable_autoformat = false
          else vim.g.disable_autoformat = true end
        end,
      }):map '<leader>of'
    end,
  },
}
