-- Remaps
vim.g.mapleader = ' '

-- Hot source this config
vim.keymap.set('n', '<Leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

-- Explorer bindings
vim.keymap.set('n', '<Leader>e', ':Vex<CR>')

-- Telescope bindings
--  Fuzzy find based on the current git repo
vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<CR>')
--  Fuzzy find based on the current dir
vim.keymap.set('n', '<Leader>fg', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>fh', ':Telescope help_tags<CR>')
