return {
    'RRethy/vim-illuminate',
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function()
            require('gitsigns').setup()
        end,
    },
}
