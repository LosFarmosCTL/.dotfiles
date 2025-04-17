return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- automatically install LSPs
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach-set-keymap', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- code navigation
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- editing
          map('<leader>r', vim.lsp.buf.rename, '[R]ename')
          map('<leader>.', vim.lsp.buf.code_action, 'Code Action')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- HACK: inlayHintProvider does not appear in sourcekit server_capabilities even though it is supported
          if client and (client.server_capabilities.inlayHintProvider or client.name == 'sourcekit') then
            -- stylua: ignore
            Snacks.toggle({
              name = 'Inlay [hints]',
              get = function() return vim.lsp.inlay_hint.is_enabled { bufnr = event.buf } end,
              set = function(value) vim.lsp.inlay_hint.enable(value, { bufnr = event.buf }) end,
            }):map('<leader>oh')
          end
        end,
      })

      local servers = {
        clangd = {},
        gopls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        bashls = {},
        jdtls = {},
        ts_ls = {},
        html = {},
        cssls = {},
        jsonls = {},
        eslint = {
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        },
        basedpyright = {
          setting = {
            basedpyright = {
              disableOrganizeImports = true,
            },
          },
        },
      }

      require('mason').setup()

      -- install additional tools (such as formatters/linters) using mason
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'ruff',
        'prettierd',
        'swiftlint',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- set up lspconfig via mason
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            vim.lsp.config(server_name, server)
            vim.lsp.enable(server_name)
          end,
        },
        ensure_installed = {},
        automatic_installation = true,
      }

      -- sourcekit-lsp is provided via the swift toolchain and can't be installed using mason
      vim.lsp.config('sourcekit', {
        filetypes = { 'swift', 'objective-c', 'objective-cpp' },
      })
      vim.lsp.enable 'sourcekit'
    end,
  },

  -- configures metals LSP for scala
  {
    'scalameta/nvim-metals',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    ft = { 'scala', 'sbt' },
    config = function(self)
      local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = self.ft,
        callback = function()
          local config = require('metals').bare_config()
          require('metals').initialize_or_attach(config)
        end,
        group = nvim_metals_group,
      })
    end,
  },

  -- configures lua LSP for neovim config
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
}
