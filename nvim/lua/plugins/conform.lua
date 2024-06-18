return {
    'stevearc/conform.nvim',
    opts = {},
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require 'conform'

        conform.setup {
            formatters_by_ft = {
                lua = { 'stylua' },
                -- Conform will run multiple formatters sequentially
                python = { 'isort', 'black' },
                -- Use a sub-list to run only the first available formatter
                cpp = { 'clang_format' },
            },
            format_on_save = {
                enable = false,
                timeout_ms = 500,
                lsp_fallback = true,
                async = false,
            },
        }

        vim.keymap.set('n', '<leader>fn', function()
            conform.format {

                async = false,
                timeout_ms = 500,
            }
        end, { desc = 'Format file now' })
    end,
}
