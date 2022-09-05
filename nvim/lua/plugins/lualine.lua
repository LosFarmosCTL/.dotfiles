require("lualine").setup({
    options = {
        theme = "tokyonight",
    },
    tabline = {
        lualine_b = { "buffers" },
        lualine_y = { "tabs" },
    },
})
