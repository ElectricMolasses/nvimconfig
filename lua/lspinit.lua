-- Style floating windows with borders
local border = {
    {"🭽", "FloatBorder"},
    {"▔", "FloatBorder"},
    {"🭾", "FloatBorder"},
    {"▕", "FloatBorder"},
    {"🭿", "FloatBorder"},
    {"▁", "FloatBorder"},
    {"🭼", "FloatBorder"},
    {"▏", "FloatBorder"},
}

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border}),
}

local lspconfig = require('lspconfig')

-- https://luals.github.io/#install
-- arch: lua-language-server
lspconfig.lua_ls.setup({
    handlers=handlers,
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
lspconfig.gopls.setup({
    handlers=handlers
})

-- arch: typescript-language-server
lspconfig.tsserver.setup({
    handlers=handlers
})

-- rustup: rls rust-analysis-rust-src
lspconfig.rust_analyzer.setup({
    handlers=handlers
})

