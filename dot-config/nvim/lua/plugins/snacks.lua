return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("snacks").setup {
            notifier = {
                enabled = true,
            },
            dashboard = {
                enabled = true,
                preset = {
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "header" },
                    {
                        pane = 2,
                        section = "terminal",
                        cmd = "colorscript -e square",
                        height = 5,
                        padding = 1,
                    },
                    { section = "keys", gap = 1, padding = 1 },
                    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "hub status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
            },
        }

        vim.keymap.set("n", "<leader><leader>", function()
            require("snacks").notifier.hide()
        end, { desc = "Dismiss notifications" })
        vim.keymap.set("n", "<leader>n", function()
            require("snacks").notifier.show_history()
        end, { desc = "View notifications" })
    end,
}
