return {
    setup = function()
        require("keymap").fterm.setup()
    end,
    spawn_btop = function()
        local fterm = require("FTerm")

        local btop = fterm:new({
            ft = "fterm_btop",
            cmd = "btop",
        })

        btop:toggle()
    end,
}
