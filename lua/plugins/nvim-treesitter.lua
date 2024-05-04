require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "lua",
        "vim",
        "javascript",
        "typescript",
        "svelte",
        "scss",
        "markdown",
        "clojure",
    },

    highlight = {
        enable = true,
    }
}
