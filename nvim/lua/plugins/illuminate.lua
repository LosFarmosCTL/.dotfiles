require("illuminate").configure({
    delay = 500,
    filetypes_denylist = {
        "SidebarNvim",
    },
})

vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#34364c" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#34364c" })
vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#34364c" })
