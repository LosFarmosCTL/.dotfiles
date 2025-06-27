return {
  {
    'supermaven-inc/supermaven-nvim',
    opts = {
      condition = function()
        return vim.b.copilot_suggestion_hidden
      end,
    },
    config = function(opts)
      require('supermaven-nvim').setup(opts)

      -- stylua: ignore
      Snacks.toggle({
        name = '[C]opilot/Supermaven suggestions',
        get = function() return not vim.b.copilot_suggestion_hidden end,
        set = function(state) vim.b.copilot_suggestion_hidden = not state end,
      }):map '<leader>oc'
    end,
  },
}
