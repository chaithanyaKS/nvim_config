-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('i', 'kj', '<Esc>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'copy line to system clipboard' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'delete and copy to system clipboard' })
vim.keymap.set('n', 'H', '0', { desc = 'go to begining of the line' })
vim.keymap.set('n', 'L', '$', { desc = 'go to end of the line' })

vim.keymap.set('n', '<leader>tc', vim.cmd.CopilotChatToggle, { desc = 'Toggle Copilot Chat' })
