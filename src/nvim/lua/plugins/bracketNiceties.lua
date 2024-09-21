return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local Rule = require "nvim-autopairs.rule"
            local npairs = require "nvim-autopairs"
            npairs.setup {
                disable_filetype = { "TelescopePrompt", "spectre_panel", "tex", "latex" },
                check_ts = true,
                ts_config = {
                    lua = { "string" }, -- it will not add a pair on that treesitter node
                    javascript = { "template_string" },
                    java = false, -- don't check treesitter on java
                },
            }
        end,
    },
    {
        "kawre/neotab.nvim",
        event = "InsertEnter",
        opts = {
            pairs = {
                { open = "(", close = ")" },
                { open = "[", close = "]" },
                { open = "{", close = "}" },
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = "`", close = "`" },
                { open = "<", close = ">" },
                { open = "$", close = "$" },
            },
        },
    },
}
