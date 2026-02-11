return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets',

      'moyiz/blink-emoji.nvim',
      'MahanRahmati/blink-nerdfont.nvim',
      'disrupted/blink-cmp-conventional-commits',
    },
    version = '1.*',
    opts = {
      sources = {
        default = { 'lazydev', 'lsp', 'conventional_commits', 'path', 'snippets', 'buffer', 'emoji', 'nerdfont' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          nerdfont = {
            module = 'blink-nerdfont',
            name = 'Nerd Fonts',
          },
          emoji = {
            module = 'blink-emoji',
            name = 'Emoji',
          },
          conventional_commits = {
            name = 'Conventional Commits',
            module = 'blink-cmp-conventional-commits',
            enabled = function()
              return vim.bo.filetype == 'gitcommit'
            end,
          },
        },
      },
      signature = { enabled = true },
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-y>'] = { 'select_and_accept', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
    },
  },
}
