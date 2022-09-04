vim.g.tokyonight_style = "night"
vim.g.tokyonight_sidebars = { "packer", "Outline" }

vim.cmd [[colorscheme tokyonight]]

vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#283B4D" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3C2C3C", fg = "#4d384d" })
