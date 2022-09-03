local opt = vim.opt

-- enable full color support
opt.termguicolors = true

-- set relative line numbers
opt.number = true
opt.relativenumber = true

-- setup tab indentation
opt.autoindent = true
opt.smartindent = true

opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.list = true -- display trailing spaces and tabs

-- enable undo history original
opt.undofile = true

-- smart case sensitive searching
opt.ignorecase = true
opt.smartcase = true

-- always display signcolumn
opt.signcolumn = "yes:1"

-- highlight current line
opt.cursorline = true

-- enable global status line
opt.laststatus = 3

-- decrease updatetime
opt.updatetime = 250

-- show fold column
opt.foldcolumn = "auto:3"
opt.foldminlines = 4
opt.foldnestmax = 3

opt.spell = true
