return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    keys = function()
        return {}
    end,

    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/snippets" }
        require("luasnip.loaders.from_snipmate").lazy_load { paths = "~/.config/nvim/snippets" }

        require("luasnip").setup {
            enable_autosnippets = true,
        }
    end,
}
