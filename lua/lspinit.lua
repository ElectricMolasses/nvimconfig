local lspconfig = require('lspconfig')

-- https://luals.github.io/#install
-- arch: lua-language-server
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

-- https://cs.opensource.google/go/x/tools/+/refs/tags/gopls/v0.14.2:gopls/doc/vim.md#neovim-install
-- arch: gopls
lspconfig.gopls.setup({})

-- arch: typescript-language-server
lspconfig.tsserver.setup({})

-- rustup: rls rust-analysis-rust-src
lspconfig.rust_analyzer.setup({})
