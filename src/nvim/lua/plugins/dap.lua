return {
    {
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {},
        config = function()
            local dap = require "dap"

            dap.setup {}
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap, dapui = require "dap", require "dapui"

            dapui.setup {
                layouts = {
                    {
                        elements = {
                            {
                                id = "scopes",
                                size = 0.3,
                            },
                            {
                                id = "console",
                                size = 0.7,
                            },
                        },
                        position = "bottom",
                        size = 10,
                    },
                },
            }

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("dap-python").setup()
        end,
    },
}
