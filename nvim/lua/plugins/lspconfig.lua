local servers = { "clangd", "tsserver" }
local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
cmp_capabilities.offsetEncoding = { 'utf-16' }

for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup({
        on_attach = require("keymap").lsp.setup,
        capabilities = cmp_capabilities,
    })
end
