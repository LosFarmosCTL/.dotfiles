local prettier = { 'prettierd', 'prettier', stop_after_first = true }

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        desc = '[f]ormat buffer',
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
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_fix' },
        html = prettier,
        css = prettier,
        javascript = prettier,
        javascriptreact = prettier,
        typescript = prettier,
        typescriptreact = prettier,
        json = prettier,
        jsonc = prettier,
        yaml = prettier,
        markdown = prettier,
        astro = prettier,
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
