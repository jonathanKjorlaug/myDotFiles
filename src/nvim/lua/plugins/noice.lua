return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        presets = {
            command_palette = true, -- position the cmdline and popupmenu together
        }
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    keys = {
        { '<leader><leader>', '<CMD> Noice dismiss <CR>', 'Dismiss notifications' },
        { '<leader>n', '<CMD>Telescope noice<CR>' }
    },
    config = function ()
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

        vim.keymap.set("n", "<leader><leader>", "<CMD>Noice dismiss <CR>", { desc = "Dismiss notifications"})
        vim.keymap.set("n", "<leader>n", "<CMD>Telescope noice <CR>", { desc = "View notifications"})
    end
}
