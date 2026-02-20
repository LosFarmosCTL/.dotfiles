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
        -- custom rooter to ignore .luarc.json in ~/.dotfiles/nvim/ dir
        -- LSP initialization is handled by lazydev.nvim
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          if fname == '' then
            return
          end

          local dotfiles = vim.fs.normalize(vim.fn.expand '~/.dotfiles')
          local dotfiles_root = vim.fs.root(fname, { '.git' })

          if dotfiles_root and vim.fs.normalize(dotfiles_root) == dotfiles then
            on_dir(dotfiles_root)
            return
          end

          on_dir(vim.fs.root(fname, { '.luarc.json', '.luarc.jsonc', '.git' }))
        end,
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
      copilot = {},
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
      for _, key in ipairs { 'gra', 'gri', 'grn', 'grr', 'grt' } do
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

      -- report LSP progress via OSC 9 sequences to show native progress bar in e.g. Ghostty
      vim.api.nvim_create_autocmd('LspProgress', {
        callback = function(event)
          local value = event.data.params.value
          if value.kind == 'begin' then
            io.stdout:write '\027]9;4;1;0\027\\'
          elseif value.kind == 'end' then
            io.stdout:write '\027]9;4;0\027\\'
          elseif value.kind == 'report' then
            io.stdout:write(string.format('\027]9;4;1;%d\027\\', value.percentage))
          end
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach-set-keymap', { clear = true }),
        callback = function(event)
          local h = require 'utils.keymap-helpers'
          local map = function(keys, func, desc, icon)
            h.map('n', keys, func, { buffer = event.buf, desc = desc, icon = icon })
          end

          map('<leader>lr', '<CMD>LspRestart<CR>', '[l]sp [r]estart', { icon = '󰑐', color = 'azure' })

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

          map('<leader>ss', function() Snacks.picker.lsp_workspace_symbols() end, '[s]earch [s]ymbols', { icon = '󰏢', color = 'cyan' })
          map('<leader>sS', function() Snacks.picker.lsp_symbols() end, '[s]earch [S]ymbols in current file', { icon = '󰏢', color = 'cyan' })
          -- stylua: ignore end

          -- code editing
          map('<leader>cr', vim.lsp.buf.rename, '[r]ename symbol', { icon = '󰘎', color = 'cyan' })
          map('<leader>ca', vim.lsp.buf.code_action, '[a]ction', { icon = '󰌵', color = 'cyan' })

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
            map('<leader>cR', function() Snacks.rename.rename_file() end, "[R]ename file", { icon = '󱇧', color = 'cyan' })
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
        'clang-format',
        'js-debug-adapter',
        'codelldb',
        'delve',
      },
      auto_update = true,
    },
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
