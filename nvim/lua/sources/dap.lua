-- Custom Trouble source for DAP breakpoints
-- Shows all breakpoints with their conditions, hit counts, and log messages

local Item = require 'trouble.item'

local M = {}

local BP_ICONS = {
  regular = '●',
  conditional = '◉',
  logpoint = '◆',
  hitcount = '◉',
}

---@type trouble.Source.get
M.get = function(cb, ctx)
  local breakpoints = require('dap.breakpoints').get()
  local items = {}

  for buf, buf_bps in pairs(breakpoints) do
    local bufnr = type(buf) == 'number' and buf or vim.fn.bufnr(buf)
    if bufnr == -1 then
      goto continue
    end

    local filename = vim.api.nvim_buf_get_name(bufnr)
    if filename == '' then
      goto continue
    end

    for _, bp in ipairs(buf_bps) do
      local bp_type, bp_icon, message

      if bp.logMessage and bp.logMessage ~= '' then
        bp_type = 'logpoint'
        bp_icon = BP_ICONS.logpoint
        message = 'log: ' .. bp.logMessage
      elseif bp.condition and bp.condition ~= '' then
        bp_type = 'conditional'
        bp_icon = BP_ICONS.conditional
        message = 'when ' .. bp.condition
      elseif bp.hitCondition and bp.hitCondition ~= '' then
        bp_type = 'hitcount'
        bp_icon = BP_ICONS.hitcount
        message = 'when hit ' .. bp.hitCondition .. ' times'
      else
        bp_type = 'regular'
        bp_icon = BP_ICONS.regular
        message = '' -- show just the code
      end

      local item = Item.new {
        source = 'dap',
        buf = bufnr,
        filename = filename,
        pos = { bp.line, 0 },
        end_pos = { bp.line, -1 },
        item = {
          bp_type = bp_type,
          bp_icon = bp_icon,
          message = message,
          breakpoint = bp,
        },
      }

      table.insert(items, item)
    end

    ::continue::
  end

  Item.add_text(items, { mode = 'after' })
  cb(items)
end

return M
