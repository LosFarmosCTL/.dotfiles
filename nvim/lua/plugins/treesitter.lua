return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'

      -- stylua: ignore
      ts.install {
        -- Core Neovim
        'lua', 'vim', 'vimdoc', 'query', 'regex', 'luadoc', 'luap',
        -- Web
        'javascript', 'typescript', 'tsx', 'html', 'css', 'scss',
        'json', 'json5', 'yaml', 'graphql', 'astro', 'vue', 'svelte',
        -- Systems
        'c', 'cpp', 'rust', 'go', 'zig',
        -- Apple/Mobile
        'swift', 'objc', 'kotlin',
        -- Scripting
        'python', 'ruby', 'bash', 'fish',
        -- Config files
        'toml', 'ini', 'dockerfile', 'gitignore', 'gitcommit',
        'git_config', 'ssh_config', 'tmux', 'make',
        -- Data/Docs
        'markdown', 'markdown_inline', 'xml', 'sql', 'diff', 'jsdoc', 'comment',
        -- Other
        'java',
      }

      local function enable_treesitter(buf)
        if pcall(vim.treesitter.start, buf) then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local attempted = {}
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-auto-install', { clear = true }),
        callback = function(args)
          local ft = args.match
          local buf = args.buf

          -- NOTE: disable treesitter for dockerfiles,
          -- there are some weird issues with the parser
          if ft == '' or ft == 'dockerfile' then
            return
          end

          local lang = vim.treesitter.language.get_lang(ft) or ft

          -- check if parser is already installed
          if attempted[lang] or vim.list_contains(ts.get_installed(), lang) then
            enable_treesitter(buf)
            return
          end
          attempted[lang] = true

          -- install parser if not installed
          if vim.list_contains(ts.get_available(), lang) then
            vim.notify('Installing treesitter parser: ' .. lang, vim.log.levels.INFO)

            ts.install(lang):await(vim.schedule_wrap(function(err)
              if err then
                vim.notify('Failed to install parser: ' .. lang .. ' - ' .. tostring(err), vim.log.levels.ERROR)
                return
              end

              enable_treesitter(buf)
              vim.notify('Treesitter ready: ' .. lang, vim.log.levels.INFO)
            end))
          end
        end,
      })
    end,
    -- NOTE: not technically a dependency, ensures markview.nvim is loaded before treesitter
    dependencies = { 'OXY2DEV/markview.nvim' },
  },
  {
    'davidmh/mdx.nvim',
    event = { 'BufEnter *.mdx' },
    config = function()
      vim.filetype.add { extension = { mdx = 'mdx' } }
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
    -- stylua: ignore
    keys = {
      { '<space>j', function() require('treesj').toggle() end },
    },
  },
}
