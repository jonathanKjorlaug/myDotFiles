return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        presets = {
            command_palette = true, -- position the cmdline and popupmenu together
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup {
            views = {
                cmdline_popup = {
                    position = {
                        row = 10,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                    zindex = 1000,
                },
                popupmenu = {
                    position = {
                        row = 13,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        }
    end,
}
