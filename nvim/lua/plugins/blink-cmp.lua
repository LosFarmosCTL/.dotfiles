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
    },
  },
}
