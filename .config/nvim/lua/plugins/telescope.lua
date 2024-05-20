return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        },
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local telescope = require 'telescope'
        local actions = require 'telescope.actions'

        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-j>'] = actions.move_selection_next,
                    },
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
        }

        telescope.load_extension 'fzf'

        vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files in cwd' })
        vim.keymap.set('n', '<leader>fs', '<cmd>Telescope oldfiles<cr>', { desc = 'Find string in cwd' })
        vim.keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor in cwd' })
    end,
}
