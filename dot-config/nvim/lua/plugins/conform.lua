return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>fn",
            function()
                require("conform").format { async = false, timeout_ms = 10000 }
            end,
            desc = "Format file now",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            vue = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            json = { "prettier" },
            tex = { "latexindent" },
            python = { "black" },
            nix = { "alejandra" },
            rust = { "rustfmt" },
            haskell = { "fourmolu" },
        },

        format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },

        formatters = {
            stylua = {
                -- args = { '-f /home/jonathankjorlaug/stylua.toml', "$FILENAME" },
            },
            prettier = { prepend_args = { "--tab-width", "4" } },
            latexindent = { prepend_args = { "-m" } },
        },
    },
}
