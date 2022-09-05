require("nvim_context_vt").setup({
    min_rows = 20,
    custom_parser = function(node, ft, opts)
        return "--> "
            .. vim.split(vim.treesitter.query.get_node_text(node, 0), "\n")[1]
    end,
})
