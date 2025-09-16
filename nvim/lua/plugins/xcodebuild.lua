local progress_handle

return {
  {
    'wojciech-kulik/xcodebuild.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'folke/snacks.nvim' },
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
    keys = {
      { '<leader>xb', '<cmd>XcodebuildBuild<cr>', desc = '[X]Code [B]uild' },
      { '<leader>xcb', '<cmd>XcodebuildCleanBuild<cr>', desc = '[X]Code [C]lean [B]uild' },
      { '<leader>xcd', '<cmd>XcodebuildCleanDerivedData<cr>', desc = '[X]Code [C]lean [D]erived Data' },

      { '<leader>xi', '<cmd>XcodebuildInstallApp<cr>', desc = '[X]Code [I]nstall App' },
      { '<leader>xu', '<cmd>XcodebuildUninstallApp<cr>', desc = '[X]Code [U]ninstall App' },
      { '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', desc = '[X]Code Build and [R]un' },

      { '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', desc = '[X]Code [S]elect Device' },
      { '<leader>xs', '<cmd>XcodebuildSelectScheme<cr>', desc = '[X]Code [S]elect Scheme' },
      { '<leader>xa', '<cmd>XcodebuildAssetsManager<cr>', desc = '[X]Code [A]ssets Manager' },
      -- TODO: investigate how to prevent neotest overlap
      -- TODO: code coverage?
      { '<leader>xt', '<cmd>XcodebuildTest<cr>', desc = '[X]Code [T]est' },

      {
        '<leader>xx',
        function()
          Snacks.picker.commands {
            finder = function()
              local items = require('snacks.picker.source.vim').commands()

              ---@async
              ---@param cb async fun(item: snacks.picker.finder.Item)
              return function(cb)
                items(function(item)
                  if item.text:match '^Xcodebuild' then
                    item.text = item.text:gsub('^Xcodebuild', '')
                    cb(item)
                  end
                end)
              end
            end,
            confirm = function(picker, item)
              picker:close()
              vim.cmd('Xcodebuild' .. item.text)
            end,
            layout = { preset = 'vscode' },
            title = 'XCode Commands',
            search = 'Xcodebuild',
          }
        end,
        desc = '[X]Code [X]Actions',
      },
      { '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', desc = '[X]Code [T]oggle Logs' },
      { '<leader>xo', '<cmd>XcodebuildOpenInXcode<cr>', desc = '[X]Code [O]pen in Xcode' },
    },
  },
}
