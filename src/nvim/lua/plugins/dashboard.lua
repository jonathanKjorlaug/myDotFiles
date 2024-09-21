return {
    "nvimdev/dashboard-nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    event = "VimEnter",
    opts = function()
        local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]]

        logo = string.rep("\n", 2) .. logo .. string.rep("\n", 1)
        local header = vim.split(logo, "\n")

        local opts = {
            theme = "doom",
            config = {
                header = header,
                center = {
                    { action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
                    { action = "Telescope file_browser", desc = " Browse files", icon = " ", key = "b" },
                    { action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
                    { action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
                    { action = "Telescope find_files cwd=~/dotfiles", desc = " Config", icon = " ", key = "c" },
                    { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
                    { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
                    {
                        action = function()
                            vim.api.nvim_input "<cmd>qa<cr>"
                        end,
                        desc = " Quit",
                        icon = " ",
                        key = "q",
                    },
                },
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return { "⚡ Neovim loaded in " .. ms .. "ms" }
                end,
            },
        }

        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
            button.key_format = "  %s"
        end

        return opts
    end,
}
