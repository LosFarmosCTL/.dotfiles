------------------------------------------------
------------------ UI options ------------------
------------------------------------------------

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'

vim.opt.laststatus = 3 -- global statusline
vim.opt.showtabline = 0

-- disable mouse interactions
vim.opt.mouse = ''

-- show tabs, trailing and forced spaces
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- show search/replace while typing
vim.opt.inccommand = 'split'

-- disable builtin mode indicator, since it's included in the status bar
vim.opt.showmode = false

-- show linebreaks indented at the same level
vim.opt.breakindent = true
vim.opt.linebreak = true

-- use box drawing characters for rendering deleted sections in diffview
vim.opt.fillchars:append { diff = '╱' }

------------------------------------------------
--------------- Behavior options ---------------
------------------------------------------------

-- indent 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.undofile = true

vim.opt.virtualedit = 'block'

-- case-insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- decrese time to trigger CursorHold autocmd
vim.opt.updatetime = 250

vim.filetype.add {
  extension = {
    swiftinterface = 'swift',
  },
  filename = {
    ['.swift-format'] = 'json',
  },
}

vim.opt.shell = '/opt/homebrew/bin/fish'
