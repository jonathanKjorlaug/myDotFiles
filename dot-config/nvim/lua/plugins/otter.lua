return {
    "jmbuhr/otter.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        vim.api.nvim_create_autocmd({ "LspAttach" }, {
            pattern = { "*.md", "*.py" },
            callback = function(ev)
                require("otter").activate({ "python", "markdown" }, true, true, nil)
            end,
        })
    end,
}
