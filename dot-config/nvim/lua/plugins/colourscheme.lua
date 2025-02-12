return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},

        config = function()
            vim.cmd.colorscheme "tokyonight-moon"
        end,
    },
    {
        -- "navarasu/onedark.nvim",
        "olimorris/onedarkpro.nvim",
        enabled = false,
        priority = 1000, -- Ensure it loads first
        config = function()
            vim.cmd.colorscheme "onedark"
        end,
    },
}
