return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    -- TODO: keybinds for gitbrowse + maybe dim, bufdelete
    opts = {
      bigfile = {},
      dashboard = { example = 'advanced' },
      explorer = {},
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
      scratch = {}, -- TODO: keymaps for scratch buffers, maybe configure even more quick evals
      statuscolumn = { -- TODO: investigate the entire statuscolumn + signs + folds etc. situation some more
        folds = {
          open = true,
        },
      },
      terminal = {}, -- FIXME: vi mode in fish kinda fucks everything up
      toggle = {},
      words = {},
    },
    -- stylua: ignore
    keys = {
      { '<leader>gg', function() Snacks.lazygit() end,  desc = 'Show LazyGit'},

      -- jump to next occurence of symbol using `n` if no search is active
      { 'n', function()
          if vim.v.hlsearch == 0 then Snacks.words.jump(1, true)
          else vim.cmd 'normal! n' end end, },
      { 'N', function()
          if vim.v.hlsearch == 0 then Snacks.words.jump(-1, true)
          else vim.cmd 'normal! N' end end, },

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

      { '<leader>li', function() Snacks.picker.lsp_config() end, desc = '[l]sp info' },
    },
  },
}
