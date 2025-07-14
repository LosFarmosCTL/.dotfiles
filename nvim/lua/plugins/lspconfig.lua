return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      -- automatically install LSPs
      { 'williamboman/mason.nvim', opts = {}, lazy = false },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
    },
    opts = {
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
      fish_lsp = {},
      dockerls = {},
      jdtls = {},
      ts_ls = {},
      html = {},
      cssls = {
        settings = {
          css = {
            lint = {
              unknownAtRules = 'ignore',
            },
          },
        },
      },
      tailwindcss = {},
      astro = {},
      mdx_analyzer = {},
      jsonls = {},
      yamlls = {},
      eslint = {
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_create_user_command(bufnr, 'EslintFixAll', function()
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
      sourcekit = {
        filetypes = { 'swift', 'objective-c', 'objective-cpp' },
      },
    },
    config = function(_, opts)
      -- remove default keybindings
      for _, key in ipairs { 'gra', 'gri', 'grn', 'grr' } do
        vim.keymap.del('n', key)
      end

      -- set up LSP configs
      for name, config in pairs(opts) do
        vim.lsp.config(name, config)
      end

      -- sourcekit-lsp is provided via the swift toolchain and can't be installed using mason
      vim.lsp.enable 'sourcekit'
      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_filter(function(name)
          return name ~= 'sourcekit'
        end, vim.tbl_keys(opts)),

        automatic_enable = true,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach-set-keymap', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end

          map('<leader>lr', '<CMD>LspRestart<CR>', '[l]sp [r]estart')

          -- code navigation 
          -- stylua: ignore start
          map('gd', function() Snacks.picker.lsp_definitions({
            layout = { preset = 'ivy', },
          }) end, 'LSP: [G]oto [D]efinition')
          map('gr', function() Snacks.picker.lsp_references({
            layout = { preset = 'ivy', },
          }) end, 'LSP: [G]oto [R]eferences')
          map('gI', function() Snacks.picker.lsp_implementations({
            layout = { preset = 'ivy', },
          }) end, 'LSP: [G]oto [I]mplementation')
          map('gD', function() Snacks.picker.lsp_declarations({
            layout = { preset = 'ivy', },
          }) end, 'LSP: [G]oto [D]eclaration')

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
    end,
  },

  -- automatically install formatters/linters/etc. using Mason
  {
    'mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'stylua',
        'ruff',
        'prettierd',
        'swiftlint',
      },
      auto_update = true,
    },
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
