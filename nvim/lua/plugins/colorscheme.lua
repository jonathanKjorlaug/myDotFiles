return {
  -- add catppuccin
    {
        "joshdick/onedark.vim",
        priority = 1000,
        lazy = true
    },
    { 
        "nyoom-engineering/oxocarbon.nvim"
    }, 
    {
        "rebelot/kanagawa.nvim"
    },
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000,
        config = function ()
            require("catppuccin").setup({
                integrations = {
                    dashboard = true,
                }
            })
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    }
}
