require("nvim-autopairs").setup()

-- set up integration with cmp to insert brackets after functions etc
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
)
