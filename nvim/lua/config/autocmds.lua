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
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufEnter' }, {
  group = auto_root_group,
  callback = function(data)
    local home_dir = vim.fn.expand '~'
    local root = require('snacks').git.get_root(data.buf)

    if root then
      vim.fn.chdir(root)
    end

    local current_file_path = vim.api.nvim_buf_get_name(0)
    local is_real_file = (current_file_path ~= '' and vim.api.nvim_get_option_value('buftype', { buf = 0 }) == '')

    local filename = is_real_file and vim.fn.fnamemodify(current_file_path, ':t')
    local project_name = root and vim.fn.fnamemodify(root, ':t')

    local working_directory = vim.fn.getcwd()
    if working_directory == home_dir then
      working_directory = '~'
    else
      working_directory = vim.fn.fnamemodify(working_directory, ':t')
    end

    local window_title_parts = { '' }
    if project_name then -- project root found
      table.insert(window_title_parts, project_name)
      if filename then -- editing a file within the project
        table.insert(window_title_parts, '-')
        table.insert(window_title_parts, filename)
      end
    else -- no project root found
      if filename then -- editing a file outside any detected project
        table.insert(window_title_parts, filename)
      else -- no file is open and no project root
        table.insert(window_title_parts, working_directory)
      end
    end

    -- send OSC 7 sequence to notify the terminal about the current working directory, this allows
    -- terminal emulators supporting it (like Ghostty) to open new tabs in this location
    io.stdout:write(('\x1b]7;file://%s%s\a'):format(vim.fn.hostname(), root or vim.fn.getcwd()))
    -- send OSC 0 sequence to set the terminal tab title
    io.stdout:write(('\x1b]0;%s\a'):format(table.concat(window_title_parts, ' ')))

    io.stdout:flush()
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
