vim.keymap.set("n", "<c-h>", "<c-w>h", { silent = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { silent = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { silent = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { silent = true })

-- Nvim-dap

vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint at line" })
vim.keymap.set("n", "dr", "<cmd> DapContinue <CR>", { desc = "Start or continue running debugger" })
vim.keymap.set("n", "<leader>du", "<cmd> lua require('dapui').toggle() <CR>", { desc = "Toggle dap ui" })
