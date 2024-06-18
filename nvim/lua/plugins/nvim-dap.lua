return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'jay-babu/mason-nvim-dap.nvim',
        'nvim-neotest/nvim-nio',
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        dapui.setup()

        local dap, dapui = require 'dap', require 'dapui'
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        require('mason-nvim-dap').setup {
            handlers = {},
        }

        vim.keymap.set('n', '<leader>dt', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Toggle breakpoint at line' })
        vim.keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>', { desc = 'Start or continue running debugger' })
    end,
}
