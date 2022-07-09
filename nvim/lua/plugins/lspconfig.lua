local servers =
    { { server = "clangd", setup = {} }, { server = "tsserver", setup = {} } }

local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
cmp_capabilities.offsetEncoding = { "utf-16" }

for _, lsp in ipairs(servers) do
    local setup = {
        on_attach = require("keymap").lsp.setup,
        capabilities = cmp_capabilities,
    }
    -- merge in LSP specific settings
    for k, v in pairs(lsp.setup) do
        setup[k] = v
    end

    require("lspconfig")[lsp.server].setup(setup)
end
