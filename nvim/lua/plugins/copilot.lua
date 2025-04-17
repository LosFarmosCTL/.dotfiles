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
            accept = false,
            next = '<A-j>',
            prev = '<A-k>',
          },
        },
        panel = { enabled = false },
      }

      -- NOTE: <Tab> binding has to be set manually to preserve normal tab behavior
      vim.keymap.set('i', '<Tab>', function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
        end
      end, { silent = true })

      -- stylua: ignore
      Snacks.toggle({
        name = '[C]opilot suggestions',
        get = function() return not vim.b.copilot_suggestion_hidden end,
        set = function(state) vim.b.copilot_suggestion_hidden = not state end,
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
