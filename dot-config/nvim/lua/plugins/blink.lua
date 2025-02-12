return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    -- dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
        keymap = { preset = "super-tab", ["<C-k>"] = { "select_prev", "fallback" }, ["<C-j>"] = { "select_next", "fallback" } },

        snippets = { preset = "luasnip" },

        sources = {
            default = { "snippets", "lsp", "path" },
        },

        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            ghost_text = { enabled = true },
            keyword = { range = "full" },
            accept = {
                auto_brackets = {
                    override_brackets_for_filetypes = { tex = { "", "" } },
                },
            },
        },
    },
    opts_extend = { "sources.default" },
}
