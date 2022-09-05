require("sidebar-nvim").setup({
    sections = {
        "files",
        "git",
        "diagnostics",
        "todos",
        "symbols",
    },
})

require("keymap").sidebar.setup()
