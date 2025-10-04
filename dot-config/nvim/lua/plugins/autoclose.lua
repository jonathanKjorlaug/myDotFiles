return {
    "m4xshen/autoclose.nvim",
    config = function()
        require("autoclose").setup {
            keys = {
                ["$"] = { escape = true, close = true, pair = "$$", enabled_filetypes = { "tex", "latex" } },
                ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { "tex", "latex", "markdown" } },
            },
            options = {

                disable_when_touch = true,
            },
        }
    end,
}
