return {
  -- add catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function ()
            require("catppuccin").setup({
                integrations = {
                    dashboard = true,
                    native_lsp = {
                        enabled = true,
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                    },
                    mason = true,
                    cmp = true,
                    telescope = true,
                    treesitter = true,
                    treesitter_context = true,
                    which_key = true,
                }
            })
            vim.cmd.colorscheme "catppuccin-macchiato"
        end,
    },
}
