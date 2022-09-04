require("illuminate").configure({
    delay = 500,
})

vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#384047", })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#384047" })
vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#384047" })
