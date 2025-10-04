return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup()

        local langs = {
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
            "javascript",
            "typescript",
            "css",
            "nix",
            "r",
        }
        require("nvim-treesitter").install(langs)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = langs,
            callback = function()
                vim.treesitter.start()
            end,
        })
        -- require("nvim-treesitter.configs").setup {
        --     -- ensure_installed = "all",
        --     ensure_installed = {
        --     },
        --     auto_install = true,
        --
        --     highlight = { enable = true },
        --     indent = { enable = true },
        -- }
    end,
}
