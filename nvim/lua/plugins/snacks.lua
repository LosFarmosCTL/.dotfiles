return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      bigfile = {},
      bufdelete = {},
      dashboard = { example = 'advanced' },
      dim = {},
      explorer = {},
      gitbrowse = {},
      image = {},
      input = {},
      lazygit = {
        configure = true,
        config = {
          git = {
            paging = {
              colorArg = 'always',
              pager = 'delta --dark --paging=never',
            },
          },
        },
      },
      notifier = {},
      picker = {
        hidden = true,
        sources = {
          files = {
            hidden = true,
          },
        },
      },
      quickfile = {},
      rename = {},
      statuscolumn = { -- TODO: investigate the entire statuscolumn + signs + folds etc. situation some more
        folds = {
          open = true,
        },
      },
      toggle = {},
      words = {},
    },
    config = function(_, opts)
      require('snacks').setup(opts)

      -- stylua: ignore
      Snacks.toggle({
        name = '[D]im',
        get = function() return Snacks.dim.enabled end,
        set = function(state)
          if state then Snacks.dim.enable()
          else Snacks.dim.disable() end
        end,
      }):map('<leader>od')
    end,
    -- stylua: ignore
    keys = {
      { '<leader>gg', function() Snacks.lazygit() end,  desc = 'Show LazyGit'},

      -- jump to next occurence of symbol using `n` if no search is active
      { 'n', function()
        if vim.v.hlsearch == 0 then Snacks.words.jump(1, true)
        else
          local ok, _ = pcall(function() vim.cmd('normal! n') end)
          if not ok then vim.notify('No match found for: ' .. vim.fn.getreg('/'), vim.log.levels.WARN) end
        end end, },
      { 'N', function()
        if vim.v.hlsearch == 0 then Snacks.words.jump(-1, true)
        else
          local ok, _ = pcall(function() vim.cmd('normal! N') end)
          if not ok then vim.notify('No match found for: ' .. vim.fn.getreg('/'), vim.log.levels.WARN) end
        end end, },

      -- lsp_config, resume, recent
      { '<leader><space>', function() Snacks.picker.files() end, desc = 'Find files' },
      { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Switch buffer' },

      { '<leader>fp', function() Snacks.picker.projects() end, desc = '[f]ind [p]rojects' },
      { '<leader>fr', function() Snacks.picker.recent() end, desc = '[f]ind [r]ecent files' },
      { '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = '[f]ind neovim [c]onfig file' },

      { '<leader>/', function() Snacks.picker.lines() end, desc = 'Search current buffer' },
      { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[s]earch open buffers' },
      { '<leader>sg', function() Snacks.picker.grep() end, desc = '[s]earch by [g]rep' },
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[s]earch current [w]ord', mode = { 'n', 'x' } },

      { '<leader>sh', function() Snacks.picker.help() end, desc = '[s]earch [h]elp' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[s]earch [k]eymaps' },
      { '<leader>sp', function() Snacks.picker.lazy() end, desc = '[s]earch [p]lugin spec' },
      { '<leader>sa', function() Snacks.picker.autocmds() end, desc = '[s]earch [a]utocmds' },

      { '<leader>sc', function() Snacks.picker.command_history() end, desc = '[s]earch [c]ommand history' },
      { '<leader>sC', function() Snacks.picker.commands() end, desc = '[s]earch [c]ommands' },
      { '<leader>sn', function() Snacks.picker.notifications() end, desc = '[s]earch [n]otification history' },
      { '<leader>su', function() Snacks.picker.undo() end, desc = '[s]earch [u]ndo tree' },

      { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[s]earch [d]iagnostics' },
      { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = '[s]earch buffer [D]iagnostics' },

      { '<leader>s.', function() Snacks.picker.resume() end, desc = '[s]earch resume' },
      { '<leader>f.', function() Snacks.picker.resume() end, desc = '[f]ind resume' },

      { '<leader>\\', function() Snacks.explorer() end, desc = 'Show file explorer' },
      { '<leader>go', function() Snacks.gitbrowse() end, desc = 'git [o]pen repository in browser' },
      { '<leader>li', function() Snacks.picker.lsp_config() end, desc = '[l]sp info' },

      { '<leader>bd', function() Snacks.bufdelete.delete() end, desc = '[b]uffer [d]elete' },
      { '<leader>bD', function() Snacks.bufdelete.other() end, desc = '[b]uffer [D]elete others' },
      { '<leader>b<C-d>', function() Snacks.bufdelete.all() end, desc = '[b]uffer [d]elete all' },
    },
  },
}
