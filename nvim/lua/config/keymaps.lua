local map = vim.keymap.set

-- clear search highlights
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

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
map('n', '<leader>K', vim.diagnostic.open_float, { desc = 'Open diagnostic hover' })

-- easier terminal mode exit
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- center current line after scrolling
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- quicklly replace word under cursor
map('n', '<C-c>', 'ciw')

-- disable backspace
map('i', '<BS>', '<Nop>')
