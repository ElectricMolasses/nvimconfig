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

-- Trying out telescope file browser
vim.call('plug#', 'nvim-telescope/telescope-file-browser.nvim')

-- Harpoon looks amazing so let's try it out
vim.call('plug#', 'ThePrimeagen/harpoon', { branch = 'harpoon2' })

-- nvim-cmp for auto completion
vim.call('plug#', 'hrsh7th/cmp-nvim-lsp')
vim.call('plug#', 'hrsh7th/cmp-buffer')
vim.call('plug#', 'hrsh7th/cmp-path')
vim.call('plug#', 'hrsh7th/cmp-cmdline')
vim.call('plug#', 'hrsh7th/nvim-cmp')
--  nvim-cmp requires a snippet engine
vim.call('plug#', 'L3MON4D3/LuaSnip')

--  DSL for yuck language support
vim.call('plug#', 'elkowar/yuck.vim')

vim.call('plug#end')
