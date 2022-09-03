return require("lua-dev").setup({
    lspconfig = {
        settings = {
            Lua = {
                format = {
                    enable = false,
                },
            },
        },
    },
})
