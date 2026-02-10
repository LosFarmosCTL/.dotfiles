local map = require('utils.keymap-helpers').map

map('n', '<C-q>', '<cmd>qa<CR>', { desc = 'Quit neovim', icon = { icon = '󰩈', color = 'red' } })
map('n', '<C-S-q>', '<cmd>qa!<CR>', { desc = 'Quit neovim without saving', icon = { icon = '󰩈', color = 'red' } })
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file', icon = { icon = '󰆓', color = 'green' } })

-- switch ; and :
map('n', ';', ':')
map('n', ':', ';')

-- remap [jk] to g[jk] to navigate between visual instead of logical lines (when wrapped)
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- lazy.nvim
map('n', '<leader>L', '<cmd>Lazy<CR>', { desc = 'Open [L]azy', icon = { icon = '󰒲', color = 'purple' } })

-- clear search highlights
map('n', '<leader><Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights', icon = { icon = '󰸱', color = 'yellow' } })

-- tab navigation
map('n', '<leader><tab><tab>', '<cmd>tabnew<CR>', { desc = '[n]ew tab', icon = { icon = '󰓜', color = 'green' } })
map('n', '<leader><tab>d', '<cmd>tabclose<CR>', { desc = '[d]elete tab', icon = { icon = '󰩹', color = 'red' } })
map('n', '<leader><tab>[', '<cmd>tabprevious<CR>', { desc = '[p]revious tab', icon = { icon = '󰮳', color = 'azure' } })
map('n', '<leader><tab>]', '<cmd>tabnext<CR>', { desc = '[n]ext tab', icon = { icon = '󰮱', color = 'azure' } })

-- split navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window', icon = { icon = '󰜴', color = 'blue' } })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window', icon = { icon = '󰜶', color = 'blue' } })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window', icon = { icon = '󰜯', color = 'blue' } })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window', icon = { icon = '󰜷', color = 'blue' } })

-- split resizing
map('n', '<C-S-h>', '<C-w><', { desc = 'Decrease split width', icon = { icon = '󰩤', color = 'grey' } })
map('n', '<C-S-l>', '<C-w>>', { desc = 'Increase split width', icon = { icon = '󰩥', color = 'grey' } })
map('n', '<C-S-k>', '<C-w>-', { desc = 'Decrease split height', icon = { icon = '󰩜', color = 'grey' } })
map('n', '<C-S-j>', '<C-w>+', { desc = 'Increase split height', icon = { icon = '󰩛', color = 'grey' } })

-- yank to system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard', icon = { icon = '󰆏', color = 'green' } })

-- Diagnostic keymaps
map('n', '<leader>K', function()
  vim.diagnostic.open_float { source = true }
end, { desc = 'Open diagnostic hover', icon = { icon = '󰘥', color = 'cyan' } })

-- easier terminal mode exit
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode', icon = { icon = '󰩈', color = 'red' } })

-- center current line after scrolling
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- quicklly replace word under cursor
map('n', '<C-c>', 'ciw')
