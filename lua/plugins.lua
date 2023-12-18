vim.call('plug#begin', '~/.config/nvim/plugins')

-- Deps
vim.call('plug#', 'nvim-tree/nvim-web-devicons')
vim.call('plug#', 'nvim-lua/plenary.nvim')

-- Themes
vim.call('plug#', 'catppuccin/nvim')

-- Who could survive the modern world without an LSP?
vim.call('plug#', 'neovim/nvim-lspconfig')

-- Telescope and friends!
vim.call('plug#', 'nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
vim.call('plug#', 'nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
vim.call('plug#', 'nvim-telescope/telescope.nvim', { branch = '0.1.x' })

-- Harpoon looks amazing so let's try it out
vim.call('plug#', 'ThePrimeagen/harpoon', { branch = 'harpoon2' })

vim.call('plug#end')
