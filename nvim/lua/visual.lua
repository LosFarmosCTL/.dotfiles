vim.opt.fillchars = vim.opt.fillchars + 'diff:╱'

vim.notify = require("notify")

-- HACK: lukas-reineke/indent-blankline.nvim#118 -- fix indent chars overlapping foldtext + not being shown after opening folds
local fix_indentline_folding =
    vim.api.nvim_create_augroup("fix_indentline_folding", {})
vim.api.nvim_create_autocmd("CursorMoved", {
    command = "IndentBlanklineRefresh",
    group = fix_indentline_folding,
})

-- turn on folding by markers instead of treesitter when editing nvim config lua files
local foldmethod_marker = vim.api.nvim_create_augroup("foldmethod_marker", {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    command = "setlocal foldmethod=marker foldexpr=0 foldlevel=0",
    group = foldmethod_marker,
})

-- highlight text on yank
local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
    group = highlight_yank,
})
