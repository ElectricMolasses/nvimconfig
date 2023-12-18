-- Remaps
vim.g.mapleader = ' '

-- Hot source this init config
-- vim.keymap.set('n', '<Leader><CR>', ':so ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<Leader><CR>', function()
    -- Clear lua module caches so requires run again.
    package.loaded['plugins'] = nil
    package.loaded['settings'] = nil
    package.loaded['lspinit'] = nil
    package.loaded['bindings'] = nil

    -- Now we re-run the source command.
    vim.cmd('source ~/.config/nvim/init.lua')
end)

-- Explorer bindings
vim.keymap.set('n', '<Leader>e', ':Vex<CR>')

-- Telescope bindings
--  Fuzzy find based on the current git repo
vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<CR>')
--  Fuzzy find based on the current dir
vim.keymap.set('n', '<Leader>fg', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>fh', ':Telescope help_tags<CR>')

-- Harpoon bindings
--  For simplicity, we just run setup where we create bindings for it.
local harpoon = require('harpoon')
harpoon:setup()

--  Create a harpoon mark
vim.keymap.set('n', '<Leader>hm', function() harpoon:list():append() end)
--  View harpoon marks
vim.keymap.set('n', '<Leader>hv', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
