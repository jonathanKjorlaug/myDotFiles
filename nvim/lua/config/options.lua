-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indent
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.autoindent = true
vim.o.breakindent = true

-- Column
vim.wo.number = true
vim.wo.signcolumn = "yes"
vim.o.relativenumber = true

-- Line
vim.o.wrap = false
vim.o.cursorline = true


-- Fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 2

-- Spell
vim.opt.spelllang = "nn,en_gb"
vim.opt.spell = true

-- Yank highlight
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Other
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true


vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.cmd.colorscheme("tokyonight-storm")
