require("gitsigns").setup({
    numhl = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
    },
    on_attach = require("keymap").gitsigns.setup,
})
