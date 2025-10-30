-- Style floating windows with borders
local border = {
    {"┌", "FloatBorder"},
    {"─", "FloatBorder"},
    {"┐", "FloatBorder"},
    {"│", "FloatBorder"},
    {"┘", "FloatBorder"},
    {"─", "FloatBorder"},
    {"└", "FloatBorder"},
    {"│", "FloatBorder"},
}

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border}),
}

-- c: clangd
vim.lsp.config('clangd', {})

-- java: nvim-jdtls
-- require('jdtls').start_or_attach({
--   cmd = {'/usr/bin/jdtls'},
--   root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true})[1]),
-- })

-- https://luals.github.io/#install
-- arch: lua-language-server
vim.lsp.config('lua_ls', {
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
vim.lsp.config('gopls', {
    handlers=handlers
})

-- arch: typescript-language-server
vim.lsp.config('ts_ls', {
  init_options = { hostInfo = 'neovim' },
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_dir = function(buf)
    return vim.fs.root(buf, {'tsconfig.json', 'jsconfig.json', 'package.json', '.git'})
      or vim.uv.cwd()
  end,
  -- root_dir = vim.fs.root(0, {'tsconfig.json', 'jsconfig.json', 'package.json', '.git'}),
  single_file_support = true,
})

-- npm: vscode-langservers-extracted
vim.lsp.config('jsonls', {});

-- svelte: github.com/sveltejs/language-tools
--  You can install the LSP per project via npm's 'svelte-language-server' package.
vim.lsp.config('svelte', {});

-- vue
vim.lsp.config('vuels', {});

-- rustup: rls rust-analysis-rust-src
vim.lsp.config('rust_analyzer', {
    handlers=handlers
})

-- phpactor
vim.lsp.config('phpactor', {
    handlers=handlers,
    init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
    }
})

-- pyright
vim.lsp.config('pyright', {
    handlers=handlers,
})

-- clojure
vim.lsp.config('clojure', {})

-- toml
vim.lsp.config('taplo', {})

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

--- Godot baybee
vim.lsp.config('gdscript', {
  handlers=handlers,
})

--- Arduino LSP
vim.lsp.config('arduino_language_server', {
  cmd = {
    "arduino-language-server",
    "-fqbn", "arduino:avr:nano",
  }
})

vim.lsp.config('emmet_ls', {
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
      rust = "html",
    },
  },
})

vim.lsp.config('somesass_ls', {})


vim.lsp.enable({
  'ts_ls',
  'jsonls',
  'gdscript',
})
