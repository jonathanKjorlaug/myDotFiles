return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        -- 'kdheepak/cmp-latex-symbols'
    },

    config = function()
        local cmp = require "cmp"
        local luasnip = require "luasnip"

        cmp.setup {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            completion = {
                completeopt = "menu,menuone,preview",
            },

            mapping = cmp.mapping.preset.insert {
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm { select = true }
                        end
                    elseif luasnip.jumpable() then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end),
            },

            sources = cmp.config.sources {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "calc" },
                { name = "buffer" },
                { name = "path" },
                -- { name = "latex_symbols" }
            },

            window = {
                completion = cmp.config.window.bordered {
                    winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
                    side_padding = 1,
                },
            },

            formatting = {
                fields = { "kind", "abbr" },
                format = function(entry, vim_item)
                    if vim.tbl_contains({ "path" }, entry.source.name) then
                        local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                        if icon then
                            vim_item.kind = icon
                            vim_item.kind_hl_group = hl_group
                            return vim_item
                        end
                    end
                    return require("lspkind").cmp_format { with_text = false }(entry, vim_item)
                end,
            },
        }
    end,
}
