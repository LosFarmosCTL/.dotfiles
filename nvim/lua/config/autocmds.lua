local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup 'highlight-yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close certain filetypes with q -- idea taken from folke/LazyVim
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close-filetypes-with-q',
  pattern = {
    'grug-far',
    'neotest-summary',
    'neotest-output',
    'neotest-output-panel',
    'help',
    'fugitiveblame',
    'git',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- auto rooter
vim.g.cwd_before_auto_root = vim.uv.cwd()
local auto_root_group = augroup 'auto-root'
vim.api.nvim_create_autocmd('BufEnter', {
  group = auto_root_group,
  callback = function(data)
    local root = require('snacks').git.get_root(data.buf)
    if root then
      vim.fn.chdir(root)

      -- send OSC 7 escape sequence to notify terminal about new working directory
      local stdout = vim.uv.new_tty(1, false)
      if stdout ~= nil then
        stdout:write(('\x1b]7;file://%s%s\a'):format(vim.fn.hostname(), root))
        stdout:close()
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
