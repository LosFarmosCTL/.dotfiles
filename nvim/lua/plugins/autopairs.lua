return {
  { 'windwp/nvim-ts-autotag', event = { 'BufReadPre', 'BufNewFile' }, opts = {} },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { map_bs = false } },
}
