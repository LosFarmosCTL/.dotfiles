local M = {
  buffer = {}, -- Buffered icons: { ['n_<leader>w'] = icon_spec }
  applied = {}, -- Track which icons have been applied
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

-- Generate unique key for mode+lhs+buffer+ft combination
local function make_key(mode, lhs, buffer, ft)
  local mode_key = normalize_mode(mode)
  local ft_key = normalize_ft(ft) or ''
  local buf_key = buffer and tostring(buffer) or ''
  return table.concat({ mode_key, lhs, buf_key, ft_key }, '_')
end

-- Register an icon (buffer if which-key not loaded, apply immediately if loaded)
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
    local wk = require('which-key')
    wk.add { wk_spec }
    M.applied[key] = wk_spec
  else
    M.buffer[key] = wk_spec
  end
end

-- Unregister an icon (for vim.keymap.del cleanup)
function M.unregister(lhs, opts)
  opts = opts or {}
  local mode = opts.mode or 'n'
  local key = make_key(mode, lhs, opts.buffer, opts.ft)

  -- Remove from buffer if present
  M.buffer[key] = nil

  -- Note: which-key doesn't have an unregister API, but we track it
  M.applied[key] = nil
end

-- Flush all buffered icons (called by which-key when loaded)
function M.flush()
  M.wk_loaded = true
  local wk = require('which-key')

  for key, data in pairs(M.buffer) do
    wk.add { data }
    M.applied[key] = data
  end

  M.buffer = {}
end

return M
