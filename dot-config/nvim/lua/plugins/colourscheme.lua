return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        enabled = false,
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
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup {
                options = {
                    terminal_colors = true, -- apply theme to terminal
                },
            }
            vim.cmd.colorscheme "nightfox"
        end,
    },
}
