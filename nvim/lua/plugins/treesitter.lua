return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
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
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {}
    end,
    keys = function()
      -- stylua: ignore
      local function sel(query)
        return function() require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects') end
      end

      -- stylua: ignore
      local function swap_n(query)
        return function() require('nvim-treesitter-textobjects.swap').swap_next(query) end
      end

      -- stylua: ignore
      local function swap_p(query)
        return function() require('nvim-treesitter-textobjects.swap').swap_previous(query) end
      end

      return {
        { 'af', sel '@function.outer', mode = { 'x', 'o' }, desc = 'Select outer function' },
        { 'if', sel '@function.inner', mode = { 'x', 'o' }, desc = 'Select inner function' },
        { 'ac', sel '@class.outer', mode = { 'x', 'o' }, desc = 'Select outer class' },
        { 'ic', sel '@class.inner', mode = { 'x', 'o' }, desc = 'Select inner class' },
        { 'ae', sel '@call.outer', mode = { 'x', 'o' }, desc = 'Select outer call' },
        { 'ie', sel '@call.inner', mode = { 'x', 'o' }, desc = 'Select inner call' },
        { 'as', sel '@statement.outer', mode = { 'x', 'o' }, desc = 'Select outer statement' },
        { 'is', sel '@statement.inner', mode = { 'x', 'o' }, desc = 'Select inner statement' },

        { '<leader>jf', swap_n '@function.outer', desc = 'Swap with next function' },
        { '<leader>kf', swap_p '@function.outer', desc = 'Swap with previous function' },
        { '<leader>js', swap_n '@statement.outer', desc = 'Swap with next statement' },
        { '<leader>ks', swap_p '@statement.outer', desc = 'Swap with previous statement' },
        { '<leader>ji', swap_n '@conditional.outer', desc = 'Swap with next `if`' },
        { '<leader>ki', swap_p '@conditional.outer', desc = 'Swap with previous `if`' },

        { '<C-s>', swap_n '@parameter.inner', desc = 'Swap argument right' },
        { '<C-S-s>', swap_p '@parameter.inner', desc = 'Swap argument left' },
      }
    end,
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
      { '<space>J', function() require('treesj').toggle() end, desc = 'Split/[J]oin block' },
    },
  },
}
