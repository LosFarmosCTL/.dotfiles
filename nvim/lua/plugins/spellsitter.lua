require("spellsitter").setup()

local disable_spellsitter =
    vim.api.nvim_create_augroup("disable_spellsitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    patter = { "Outline" },
    command = "setlocal nospell",
    group = disable_spellsitter,
})
