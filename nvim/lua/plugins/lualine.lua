local function xcodebuild_device()
  if vim.g.xcodebuild_platform == 'macOS' then
    return ' macOS'
  end

  local deviceIcon = ''
  if vim.g.xcodebuild_platform:match 'watch' then
    deviceIcon = '􀟤'
  elseif vim.g.xcodebuild_platform:match 'tv' then
    deviceIcon = '􀡴 '
  elseif vim.g.xcodebuild_platform:match 'vision' then
    deviceIcon = '􁎖 '
  end

  if vim.g.xcodebuild_os then
    return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name .. ' (' .. vim.g.xcodebuild_os .. ')'
  end

  return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        disabled_filetypes = { 'snacks_dashboard' },
        ignore_focus = { 'snacks_picker_input' },
        globalstatus = true,
      },
      sections = {
        lualine_b = {
          'branch',
          { 'diff', source = diff_source },
          'diagnostics',
        },
        lualine_c = {
          { "' ' .. vim.g.xcodebuild_last_status", color = { fg = 'Gray' } },
          {
            'filename',
            path = 1,
            symbols = {
              modified = '●',
              readonly = '',
            },
          },
        },
        lualine_x = {
          'encoding',
          'fileformat',
          'filetype',
          {
            'lsp_status',
            icon = ' ',
            ignore_lsp = { 'copilot' },
          },
          { "'󰙨 ' .. vim.g.xcodebuild_test_plan", color = { fg = '#a6e3a1', bg = '#161622' } },
          { xcodebuild_device, color = { fg = '#f9e2af', bg = '#161622' } },
        },
        lualine_y = {
          'location',
        },
        lualine_z = {
          {
            'tabs',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
          },
        },
      },
    },
  },
}
