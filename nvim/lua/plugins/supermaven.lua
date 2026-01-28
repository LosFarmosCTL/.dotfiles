return {
  {
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    opts = {},
    config = function(_, opts)
      require('supermaven-nvim').setup(opts)

      Snacks.toggle({
        name = '[C]opilot/Supermaven suggestions',
        get = function()
          return require('supermaven-nvim.api').is_running() -- and require('sidekick.nes').enabled
        end,
        set = function(state)
          if state then
            require('supermaven-nvim.api').start()
            -- require('sidekick.nes').enable()
          else
            require('supermaven-nvim.api').stop()
            -- require('sidekick.nes').disable()
          end
        end,
      }):map '<leader>oc'
    end,
  },
}
