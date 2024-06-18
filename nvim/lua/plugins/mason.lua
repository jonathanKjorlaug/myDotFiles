return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
        local mason = require 'mason'
        local mason_lspconfig = require 'mason-lspconfig'

        mason.setup {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        }

        require('mason-tool-installer').setup {
            ensure_installed = {
                'lua_ls',
                'bashls',
                'clangd',
                'dockerls',
                'jsonls',
                'texlab',
                'markdown_oxide',
                'basedpyright',
                'taplo',
                'stylua',
                'isort',
                'black',
                'clang-format',
                'codelldb',
                'debugpy',
                'hyprls',
            },
            automatic_installation = true,
        }

        mason_lspconfig.setup {
            automatic_installation = true,
        }
    end,
}
