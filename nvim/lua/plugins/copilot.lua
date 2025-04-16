return {
  {
    'zbirenbaum/copilot.lua',
    event = 'VeryLazy',
    config = function()
      -- TODO: decide on whether I want auto triggering suggestions or not
      require('copilot').setup {
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = '<Tab>',
            next = '<A-j>',
            prev = '<A-k>',
          },
        },
        panel = { enabled = false },
      }

      Snacks.toggle({
        name = 'Copilot suggestions',
        get = function()
          return not vim.b.copilot_suggestion_hidden
        end,
        set = function(state)
          vim.b.copilot_suggestion_hidden = not state
        end,
      }):map '<leader>oc'
    end,
  },
  -- TODO: copilot chat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    opts = {},
  },
}
