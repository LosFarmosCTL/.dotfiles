local set_breakpoint = function(prompt, type)
  vim.ui.input({ prompt = prompt }, function(input)
    if input and input ~= '' then
      local condition, hit_condition, log_message = nil, nil, nil
      if type == 'conditional' then
        condition = input
      elseif type == 'hit' then
        hit_condition = input
      elseif type == 'log' then
        log_message = input
      end

      require('dap').set_breakpoint(input, condition, hit_condition, log_message)
    end
  end)
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    -- stylua: ignore
    keys = {
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = '[d]ebug: toggle [b]reakpoint' },
      { '<leader>dB', function() set_breakpoint('Breakpoint condition: ', 'conditional') end, desc = '[d]ebug: conditional [B]reakpoint', },
      { '<leader>dl', function() set_breakpoint('Log message: ', 'log') end, desc = '[d]ebug: [l]og point', },
      { '<leader>dh', function() set_breakpoint('Hit condition: ', 'hit') end, desc = '[d]ebug: [h]it condition breakpoint', },
      { '<leader>dc', function() require('dap').continue() end, desc = '[d]ebug: [c]ontinue / start' },
      { '<leader>dd', function() require('dap').disconnect() end, desc = '[d]ebug: [d]isconnect' },
      { '<leader>dt', function() require('dap').terminate() end, desc = '[d]ebug: [t]erminate' },
      { '<leader>dR', function() require('dap').run_to_cursor() end, desc = '[d]ebug: [R]un to cursor' },
      { '<leader>dp', function() require('dap').pause() end, desc = '[d]ebug: [p]ause' },
    },
    config = function()
      local dap = require 'dap'

      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◉', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '✖', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = { command = 'js-debug-adapter', args = { '${port}' } },
      }

      for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' } do
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
        }
      end

      -- codelldb needs to use the xcode lldb library to properly debug swift
      local libLLDB = '/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB'
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = { command = 'codelldb', args = { '--port', '${port}', '--liblldb', libLLDB } },
      }

      for _, language in ipairs { 'c', 'cpp' } do
        dap.configurations[language] = {
          {
            name = 'Launch file',
            type = 'codelldb',
            request = 'launch',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
          },
        }
      end

      dap.configurations.rust = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.configurations.swift = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/.build/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.adapters.delve = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'dlv',
          args = { 'dap', '-l', '127.0.0.1:${port}' },
        },
      }

      dap.configurations.go = {
        { type = 'delve', name = 'Debug', request = 'launch', program = '${file}' },
        { type = 'delve', name = 'Debug test', request = 'launch', mode = 'test', program = '${file}' },
        { type = 'delve', name = 'Debug test (go.mod)', request = 'launch', mode = 'test', program = './${relativeFileDirname}' },
      }

      local arrow_keys_active = false
      -- stylua: ignore
      local function setup_debug_keymaps()
        if arrow_keys_active then return end

        arrow_keys_active = true
        vim.keymap.set('n', '<Down>', function() require('dap').step_over() end, { desc = 'Debug: Step over' })
        vim.keymap.set('n', '<Right>', function() require('dap').step_into() end, { desc = 'Debug: Step into' })
        vim.keymap.set('n', '<Left>', function() require('dap').step_out() end, { desc = 'Debug: Step out' })
        vim.keymap.set('n', '<Up>', function() require('dap').step_back() end, { desc = 'Debug: Step back' })
      end

      -- stylua: ignore
      local function cleanup_debug_keymaps()
        if not arrow_keys_active then return end

        pcall(vim.keymap.del, 'n', '<Down>')
        pcall(vim.keymap.del, 'n', '<Right>')
        pcall(vim.keymap.del, 'n', '<Left>')
        pcall(vim.keymap.del, 'n', '<Up>')

        arrow_keys_active = false
      end

      dap.listeners.after.event_initialized['dap_keys'] = setup_debug_keymaps
      dap.listeners.before.event_terminated['dap_keys'] = cleanup_debug_keymaps
      dap.listeners.before.event_exited['dap_keys'] = cleanup_debug_keymaps

      -- wrap breakpoint toggle function to fire user event for Trouble auto-refresh
      local dap_breakpoints = require 'dap.breakpoints'
      local original_toggle = dap_breakpoints.toggle
      ---@diagnostic disable-next-line: duplicate-set-field
      dap_breakpoints.toggle = function(...)
        local result = original_toggle(...)
        vim.api.nvim_exec_autocmds('User', { pattern = 'DapBreakpointsChanged' })
        return result
      end
    end,
  },
}
