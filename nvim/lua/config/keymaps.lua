local map = vim.keymap.set

map('n', '<C-q>', '<cmd>qa<CR>', { desc = 'Quit neovim' })
map('n', '<C-S-q>', '<cmd>qa!<CR>', { desc = 'Quit neovim without saving' })
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

-- switch ; and :
map('n', ';', ':')
map('n', ':', ';')

-- remap [jk] to g[jk] to navigate between visual instead of logical lines (when wrapped)
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- lazy.nvim
map('n', '<leader>L', '<cmd>Lazy<CR>', { desc = 'Open [L]azy' })

-- clear search highlights
map('n', '<leader><Esc>', '<cmd>nohlsearch<CR>')

-- tab navigation
map('n', '<leader><tab><tab>', '<cmd>tabnew<CR>')
map('n', '<leader><tab>d', '<cmd>tabclose<CR>')
map('n', '<leader><tab>[', '<cmd>tabprevious<CR>')
map('n', '<leader><tab>]', '<cmd>tabnext<CR>')

-- split navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- split resizing
map('n', '<C-S-h>', '<C-w><', { desc = 'Decrease split width' })
map('n', '<C-S-l>', '<C-w>>', { desc = 'Increase split width' })
map('n', '<C-S-k>', '<C-w>-', { desc = 'Decrease split height' })
map('n', '<C-S-j>', '<C-w>+', { desc = 'Increase split height' })

map('n', '<leader>bd', '<CMD>bdelete<CR>', { desc = '[B]uffer [D]elete' })

-- yank to system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })

-- Diagnostic keymaps
map('n', '<leader>K', function()
  vim.diagnostic.open_float { source = true }
end, { desc = 'Open diagnostic hover' })

-- easier terminal mode exit
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- center current line after scrolling
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- quicklly replace word under cursor
map('n', '<C-c>', 'ciw')
