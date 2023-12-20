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

-- Telescope file browser bindings
--  Open the file explorer
vim.keymap.set('n', '<Leader>fe', ':Telescope file_browser<CR>')
vim.keymap.set('n', '<Leader>fE', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')

-- Harpoon bindings
--  For simplicity, we just run setup where we create bindings for it.
local harpoon = require('harpoon')
harpoon:setup()

--  Create a harpoon mark
vim.keymap.set('n', '<Leader>hm', function() harpoon:list():append() end)
--  View harpoon marks
vim.keymap.set('n', '<Leader>hv', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Lsp bindings
--  Show hover information
vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.hover)
--  Show line diagnostics in a popup
local function show_line_diagnostics()
    local diagnostics = vim.diagnostic.get(0, {lnum = vim.api.nvim_win_get_cursor(0)[1] - 1})
    local lines = {}

    for _, diag in ipairs(diagnostics) do
        for _, line in ipairs(vim.split(diag.message, '\n', true)) do
            table.insert(lines, line)
        end
    end

    if #lines == 0 then return end

    local border_opts = {
        border = "single",
        focusable = false,
        style = "minimal",
        relative = "cursor",
        row = 1,
        col = 0,
    }

    vim.lsp.util.open_floating_preview(lines, "plaintext", border_opts)
end
vim.keymap.set('n', '<Leader>ld', show_line_diagnostics)

-- Attach local buffer options on LSP connect
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        -- Jump to declaration/definition in buffer
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    end
})
