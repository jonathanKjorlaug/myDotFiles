return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("mason").setup {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        }

        require("mason-tool-installer").setup {
            ensure_installed = {
                -- LSP
                "lua_ls",
                "bashls",
                "jsonls",
                "taplo",
                "hyprls",

                "docker-compose-language-service",
                "dockerfile-language-server",

                "clangd",

                "texlab",

                "tsserver",

                -- Formatter
                "stylua",
                "black",
                "clang-format",
                "prettier",
            },
            automatic_installation = true,
        }

        require("mason-lspconfig").setup {
            automatic_installation = true,
        }

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require "lspconfig"
        local opts = { noremap = true }

        require("mason-lspconfig").setup_handlers {
            function(server_name)
                require("lspconfig")[server_name].setup {
                    capabilities = capabilities,
                }
            end,

            ["lua_ls"] = function()
                lspconfig.lua_ls.setup {
                    capabilities = capabilities,
                    settings = { -- custom settings for lua
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                                    [vim.fn.stdpath "config" .. "/lua"] = true,
                                },
                            },
                        },
                    },
                }
            end,

            ["clangd"] = function()
                lspconfig.clangd.setup {
                    capabilities = capabilities,
                    keys = {
                        { "<leader>fh", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                    },
                }
            end,

            ["texlab"] = function()
                lspconfig.texlab.setup {
                    on_attach = function()
                        opts.desc = "Compile now"
                        vim.keymap.set("n", "<leader>lc", "<cmd>TexlabBuild<cr>", opts)

                        opts.desc = "Open pdf"
                        vim.keymap.set("n", "<leader>lo", "<cmd>TexlabForward<cr>", opts)

                        vim.keymap.set("n", "j", "gj", { silent = true })

                        vim.keymap.set("n", "k", "gk", { silent = true })

                        vim.o.wrap = true
                    end,
                    settings = {
                        texlab = {
                            build = {
                                forwardSearchAfter = true,
                                onSave = true,
                                args = {
                                    "-pdf",
                                    "-interaction=nonstopmode",
                                    "-outdir=builddir",
                                    "-synctex=1",
                                    "%f",
                                },

                                auxDirectory = "./builddir",
                                pdfDirectory = "./builddir",
                                logDirectory = "./builddir",
                            },

                            forwardSearch = {
                                executable = "zathura",
                                args = {
                                    "--synctex-forward",
                                    "%l:1:%f",
                                    "%p",
                                },
                                onSave = true,
                            },
                        },
                    },
                }
            end,
        }

        lspconfig.hyprls.setup {
            filetypes = { "*.hl", "hypr*.conf", ".config/hypr/*.conf", "hyprlang" },
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                opts.buffer = ev.buf

                opts.desc = "Show LSP references"
                vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Go to definitions"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Go to type definitions"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>fD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float, opts)

                opts.desc = "Show documentation for what is under the cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
            end,
        })
    end,
}
