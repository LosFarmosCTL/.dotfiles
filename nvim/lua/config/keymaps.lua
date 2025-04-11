-- clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- split resizing
vim.keymap.set('n', '<C-S-h>', '<C-w><', { desc = 'Decrease split width' })
vim.keymap.set('n', '<C-S-l>', '<C-w>>', { desc = 'Increase split width' })
vim.keymap.set('n', '<C-S-k>', '<C-w>-', { desc = 'Decrease split height' })
vim.keymap.set('n', '<C-S-j>', '<C-w>+', { desc = 'Increase split height' })

vim.keymap.set('n', '<leader>bd', '<CMD>bdelete<CR>', { desc = '[B]uffer [D]elete' })

-- yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>K', vim.diagnostic.open_float, { desc = 'Open diagnostic hover' })

-- easier terminal mode exit
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- center current line after scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<C-c>', 'ciw')

vim.keymap.set('i', '<BS>', '<Nop>')
