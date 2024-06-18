return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
    config = function()
        require('noice').setup {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                --command_palette = true,
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },

            views = {
                cmdline_popup = {
                    border = {
                        style = 'none',
                        padding = { 1, 2 },
                    },
                    filter_options = {},
                    win_options = {
                        winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
                    },
                },
                popupmenu = {
                    border = {
                        style = 'rounded',
                    },
                    win_options = {
                        winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
                    },
                    scrollbar = false,
                },
            },

            notify = {
                enabled = false,
            },
        }
        require('telescope').load_extension 'noice'
    end,
}
