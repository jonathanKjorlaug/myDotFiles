return {
    {'windwp/nvim-autopairs', event = "InsertEnter", config = true},
    {
        'abecodes/tabout.nvim',
        lazy = false,
        event = 'InsertCharPre',
        priority = 1000,
        config = function ()
            require('tabout').setup {
                tabkey = '<Tab>',
                backwards_tabkey = '<S-Tab>',
                act_as_tab = true,
                enable_backwards = true,
                completion = true,
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' },
                    { open = '<', close = '>' },
                },
                ignore_beginning = false,
            }
        end,

    }
}
