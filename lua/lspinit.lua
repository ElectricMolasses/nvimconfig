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

-- svelte: github.com/sveltejs/language-tools
--  You can install the LSP per project via npm's 'svelte-language-server' package.
lspconfig.svelte.setup{}

-- rustup: rls rust-analysis-rust-src
lspconfig.rust_analyzer.setup({
    handlers=handlers
})

-- phpactor
lspconfig.phpactor.setup({
    handlers=handlers,
    init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
    }
})

-- pyright
lspconfig.pyright.setup({
    handlers=handlers,
})

-- clojure
lspconfig.clojure_lsp.setup{}

-- omnisharp for unity
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Omnicompletion
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- Omnisharp/C#/Unity
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/onion/Work/Tools/omnisharp-1.38.2/run"

-- lspconfig.omnisharp.setup({
--     cmd = {
--         'mono',
--         '--assembly-loader=strict',
--         omnisharp_bin,
--     },
--     use_mono = true,
-- })

-- lspconfig.omnisharp.setup{
--     on_attach = on_attach,
--     flags = {
--       debounce_text_changes = 150,
--     },
--     cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
--     root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln");
-- }
