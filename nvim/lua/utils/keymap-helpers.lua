local M = {}
local registry = require 'utils.keymap-registry'

local function merge_cond(cond, ft)
  if not ft then
    return cond
  end
  local fts = type(ft) == 'table' and ft or { ft }
  local ft_cond = function()
    return vim.tbl_contains(fts, vim.bo.filetype)
  end
  if cond == nil then
    return ft_cond
  end
  if type(cond) == 'boolean' then
    return cond and ft_cond or function()
      return false
    end
  end
  if type(cond) == 'function' then
    return function()
      return cond() and ft_cond()
    end
  end
  return ft_cond
end

function M.keys(key_table)
  for _, spec in ipairs(key_table) do
    if spec.icon then
      registry.register(spec[1], spec.icon, {
        mode = spec.mode,
        buffer = spec.buffer,
        cond = merge_cond(spec.cond, spec.ft),
      })
      spec.icon = nil
    end
  end
  return key_table
end

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  if opts.icon then
    registry.register(lhs, opts.icon, {
      mode = mode,
      buffer = opts.buffer,
      cond = opts.cond,
    })
    opts.icon = nil
  end
  return vim.keymap.set(mode, lhs, rhs, opts)
end

function M.unmap(mode, lhs, opts)
  registry.unregister(lhs, { mode = mode, buffer = opts and opts.buffer })
  return vim.keymap.del(mode, lhs, opts)
end

return M
