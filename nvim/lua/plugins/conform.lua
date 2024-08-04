return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>fn>",
            function()
                require("conform").format { async = false, timeout_ms = 500 }
            end,
            desc = "Format file now",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettier" },
            typescript = { "prettier" },
        },

        format_on_save = { timeout_ms = 750, lsp_format = "fallback" },

        formatters = {
            stylua = {
                -- args = { '-f /home/jonathankjorlaug/stylua.toml', "$FILENAME" },
            },
        },
    },
}
