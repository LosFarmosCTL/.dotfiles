local servers = {
    { server = "clangd", setup = {} },
    { server = "tsserver", setup = {} },
    {
        server = "sumneko_lua",
        setup = {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        },
    },
    {
        server = "sourcekit",
        setup = {
            filetypes = { "swift" },
        },
    },
}

local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
cmp_capabilities.offsetEncoding = { "utf-16" }

for _, lsp in ipairs(servers) do
    local on_attach = function(client)
        require("lsp-format").on_attach(client)

        require("keymap").lsp.setup()
    end

    local setup = {
        on_attach = on_attach,
        capabilities = cmp_capabilities,
    }
    -- merge in LSP specific settings
    for k, v in pairs(lsp.setup) do
        setup[k] = v
    end

    require("lspconfig")[lsp.server].setup(setup)
end
