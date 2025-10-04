local function find_snippets_dir()
    local dir = vim.loop.cwd()
    while dir do
        local candidate = dir .. "/nvimsnippets"
        if vim.fn.isdirectory(candidate) == 1 then
            return candidate
        end
        -- move one level up
        local parent = vim.fn.fnamemodify(dir, ":h")
        if parent == dir then
            break -- reached root
        end
        dir = parent
    end
    return nil
end

return {
    "L3MON4D3/LuaSnip",
    keys = function()
        return {}
    end,

    config = function()
        local path = find_snippets_dir()
        if vim.fn.isdirectory(path) == 1 then
            require("luasnip.loaders.from_lua").lazy_load { paths = path, priority = 100 }
        end

        require("luasnip.loaders.from_vscode").lazy_load { paths = "./snippets" }
        require("luasnip.loaders.from_lua").lazy_load { paths = "./lua/snippets" }

        local ls = require "luasnip"
        local path = vim.loop.cwd() .. "/nvimsnippets"

        require("luasnip").setup {
            enable_autosnippets = true,
        }
    end,
}
