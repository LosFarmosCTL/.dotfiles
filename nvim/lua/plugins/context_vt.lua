-- TODO: change highlight color
require("nvim_context_vt").setup({
    min_rows = 20,
    custom_parser = function(node, ft, opts)
        local ts_utils = require("nvim-treesitter.ts_utils")

        return "--> " .. ts_utils.get_node_text(node)[1]
    end,
})
