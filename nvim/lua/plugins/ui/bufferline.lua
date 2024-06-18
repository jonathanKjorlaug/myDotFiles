return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    enabled = false,
    config = function()
        require('bufferline').setup {
            options = {
                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'File explorer',
                        highlight = 'Directory',
                        text_align = 'left',
                    },
                },
                modified_icon = '●',
                separator_style = { '', '' },
                show_close_icon = false,
                show_buffer_close_icons = false,
            },
        }
    end,
}
