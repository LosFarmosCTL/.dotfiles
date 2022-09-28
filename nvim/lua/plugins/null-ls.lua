local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.formatting.prettierd,
}

null_ls.setup({
    sources = sources,
    on_attach = require("lsp-format").on_attach,
})
