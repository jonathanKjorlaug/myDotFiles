return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>b", "<CMD> Telescope file_browser <CR>", desc = "Browse files" },
    },
}
