-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- auto rooter
vim.g.cwd_before_auto_root = vim.uv.cwd()
local auto_root_group = vim.api.nvim_create_augroup('auto-root', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = auto_root_group,
  callback = function(data)
    local root_files = {
      'Package.swift',
      'package.json',
      'go.mod',
      'pom.xml',
      '.git',
      'Makefile',
    }
    local root = require('mini.misc').find_root(data.buf, root_files)

    if root then
      vim.fn.chdir(root)

      -- send OSC 7 escape sequence to notify terminal about new working directory
      local stdout = vim.uv.new_tty(1, false)
      if stdout ~= nil then
        stdout:write(('\x1b]7;file://%s%s\a'):format(vim.fn.hostname(), root))
      end
    end
  end,
})

-- send OSC 7 sequence to reset back to the original working directory
vim.api.nvim_create_autocmd('VimLeave', {
  group = auto_root_group,
  callback = function()
    local stdout = vim.uv.new_tty(1, false)
    if stdout ~= nil then
      stdout:write(('\x1b]7;file://%s%s\a'):format(vim.fn.hostname(), vim.g.cwd_before_auto_root))
    end
  end,
})
