return {
  {
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    opts = {},
    config = function(_, opts)
      require('supermaven-nvim').setup(opts)

      -- stylua: ignore
      Snacks.toggle({
        name = '[C]opilot/Supermaven suggestions',
        get = function() return require('supermaven-nvim.api').is_running() end,
        set = function()
          require('supermaven-nvim.api').toggle()
          require('sidekick.nes').toggle()
        end,
      }):map '<leader>oc'
    end,
  },
}
