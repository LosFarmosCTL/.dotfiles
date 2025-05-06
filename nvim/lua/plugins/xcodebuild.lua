local progress_handle

return {
  {
    'wojciech-kulik/xcodebuild.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    opts = {
      code_coverage = { enabled = true },
      show_build_progress_bar = false,
      logs = {
        notify = function(message, severity)
          local fidget = require 'fidget'
          if progress_handle then
            progress_handle.message = message
            if not message:find 'Loading' then
              progress_handle:finish()
              progress_handle = nil
              if vim.trim(message) ~= '' then
                fidget.notify(message, severity)
              end
            end
          else
            fidget.notify(message, severity)
          end
        end,
        notify_progress = function(message)
          local progress = require 'fidget.progress'

          if progress_handle then
            progress_handle.title = ''
            progress_handle.message = message
          else
            progress_handle = progress.handle.create {
              message = message,
              lsp_client = { name = 'xcodebuild.nvim' },
            }
          end
        end,
      },
    },
    keys = {},
  },
}
