require("github-theme").setup({
    theme_style = "dark",
    sidebars = {
        "packer",
    },
    overrides = function(c)
        return {
            Search = { fg = "#212529", bg = "#C2CBD4" },
            Folded = { bg = "#44494E" },
            FoldColumn = { fg = "#60676E", bg = "#24292E" },
            ContextVt = { fg = "#ff0000" },
        }
    end,
})
