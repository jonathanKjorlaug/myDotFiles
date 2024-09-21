return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        }
    },
    config = function ()
        local actions = require "telescope.actions"

        require("telescope").setup {
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

        require("telescope").load_extension 'fzf'


        vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files in cwd' })
        vim.keymap.set('n', '<leader>fs', '<cmd>Telescope grep_string<cr>', { desc = 'Find string in cwd' })
        vim.keymap.set('n', '<leader>fg', '<cmd>Telescope git_status<cr>', { desc = 'See changes in git'})
    end
}
