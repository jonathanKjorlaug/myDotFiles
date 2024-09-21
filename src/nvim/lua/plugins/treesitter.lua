return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "hyprlang",
                "bibtex",
                "latex",
                "cpp",
                "csv",
                "dockerfile",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "toml",
                "vue",
                "css",
            },
            auto_install = true,

            highlight = { enable = true },
            indent = { enable = true },
        }
    end,
}
