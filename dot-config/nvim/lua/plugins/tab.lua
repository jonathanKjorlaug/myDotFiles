return {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
        pairs = {
            { open = "$", close = "$" },
            { open = "(", close = ")" },
            { open = "[", close = "]" },
            { open = "{", close = "}" },
            { open = "'", close = "'" },
            { open = '"', close = '"' },
            { open = "`", close = "`" },
            { open = "<", close = ">" },
        },
    },
}
