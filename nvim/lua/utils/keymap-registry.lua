local M = {
  buffer = {},
  applied = {},
  wk_loaded = false,
}

local function normalize_mode(mode)
  if type(mode) == 'table' then
    return table.concat(mode, ',')
  end
  return mode or 'n'
end

local function normalize_ft(ft)
  if not ft then
    return nil
  end
  if type(ft) == 'table' then
    return table.concat(ft, ',')
  end
  return ft
end

local function make_key(mode, lhs, buffer, ft)
  local mode_key = normalize_mode(mode)
  local ft_key = normalize_ft(ft) or ''
  local buf_key = buffer and tostring(buffer) or ''
  return table.concat({ mode_key, lhs, buf_key, ft_key }, '_')
end

function M.register(lhs, icon_spec, opts)
  opts = opts or {}
  local mode = opts.mode or 'n'
  local key = make_key(mode, lhs, opts.buffer, opts.ft)

  local wk_spec = {
    lhs,
    icon = icon_spec,
    mode = mode,
    buffer = opts.buffer,
    cond = opts.cond,
  }

  if M.wk_loaded then
    local wk = require 'which-key'
    wk.add { wk_spec }
    M.applied[key] = wk_spec
  else
    M.buffer[key] = wk_spec
  end
end

function M.unregister(lhs, opts)
  opts = opts or {}
  local mode = opts.mode or 'n'
  local key = make_key(mode, lhs, opts.buffer, opts.ft)

  M.buffer[key] = nil
  M.applied[key] = nil
end

function M.flush()
  M.wk_loaded = true
  local wk = require 'which-key'

  for key, data in pairs(M.buffer) do
    wk.add { data }
    M.applied[key] = data
  end

  M.buffer = {}
end

return M
