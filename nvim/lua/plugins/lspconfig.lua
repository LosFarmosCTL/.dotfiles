return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
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
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end

          map('<leader>lr', '<CMD>LspRestart<CR>', '[l]sp [r]estart')

          -- code navigation 
          -- stylua: ignore start
          map('gd', function() Snacks.picker.lsp_definitions() end, 'LSP: [G]oto [D]efinition')
          map('gr', function() Snacks.picker.lsp_references() end, 'LSP: [G]oto [R]eferences')
          map('gI', function() Snacks.picker.lsp_implementations() end, 'LSP: [G]oto [I]mplementation')
          map('gD', function() Snacks.picker.lsp_declarations() end, 'LSP: [G]oto [D]eclaration')

          map('<leader>ss', function() Snacks.picker.lsp_workspace_symbols() end, '[s]earch [s]ymbols')
          map('<leader>sS', function() Snacks.picker.lsp_symbols() end, '[s]earch [S]ymbols in current file')
          -- stylua: ignore end

          -- code editing
          map('<leader>cr', vim.lsp.buf.rename, '[r]ename symbol')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- HACK: inlayHintProvider does not appear in sourcekit server_capabilities even though it is supported
          if client and (client.supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint) or client.name == 'sourcekit') then
            -- stylua: ignore
            Snacks.toggle({
              name = 'Inlay [h]ints',
              get = function() return vim.lsp.inlay_hint.is_enabled { bufnr = event.buf } end,
              set = function(value) vim.lsp.inlay_hint.enable(value, { bufnr = event.buf }) end,
            }):map('<leader>oh')
          end

          -- stylua: ignore
          if client and (
              client.supports_method(client, vim.lsp.protocol.Methods.workspace_didRenameFiles, event.buf)
              or client.supports_method(client, vim.lsp.protocol.Methods.workspace_willRenameFiles, event.buf)
            ) then
            map('<leader>cR', function() Snacks.rename.rename_file() end, "[R]ename file")
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
        tailwindcss = {},
        jsonls = {},
        eslint = {
          on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(0, 'EslintFixAll', function()
              client:exec_cmd({
                title = 'Fix all Eslint errors for current buffer',
                command = 'eslint.applyAllFixes',
                arguments = {
                  {
                    uri = vim.uri_from_bufnr(bufnr),
                    version = vim.lsp.util.buf_versions[bufnr],
                  },
                },
              }, { bufnr = bufnr })
            end, {})

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
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      }

      -- sourcekit-lsp is provided via the swift toolchain and can't be installed using mason
      vim.lsp.config('sourcekit', {
        filetypes = { 'swift', 'objective-c', 'objective-cpp' },
      })
      vim.lsp.enable 'sourcekit'
    end,
  },

  -- preview code actions
  {
    'aznhe21/actions-preview.nvim',
    opts = {
      backend = 'snacks',
      snacks = {
        layout = {
          preset = 'ivy',
        },
      },
    },
    keys = {
      {
        '<leader>ca',
        function()
          require('actions-preview').code_actions()
        end,
        mode = { 'n', 'v' },
        desc = '[a]ction',
      },
    },
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
