return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
		local db = require("dashboard")
        db.setup ({
            theme = "doom",
			disable_move = false,
			config = {
				center = {
					{
						desc = 'Files                                            ',
						group = 'Label',
						action = 'Telescope find_files',
						key = 'f',
						key_format = "%s",
        			},
					{
						desc = 'Files',
						group = 'Label',
						key = 'b',
						key_hl = 'Number',
						key_format = '%s', -- remove default surrounding `[]`
						action = 'lua print(2)'
					},
				},
				--footer = {},
			}
        })
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
