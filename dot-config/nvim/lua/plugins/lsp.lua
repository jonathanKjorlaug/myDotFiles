return {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = {
        servers = {
            nixd = {
                options = {
                    home_manager = {
                        expr = '(builtins.getFlake "/home/jonathankjorlaug/dotfiles").homeConfigurations.jonathankjorlaug.options',
                    },
                    nixos = {
                        expr = '(builtins.getFlake "/home/jonathankjorlaug/nixosConfig").nixosConfigurations.captainArcher.options',
                    },
                },
            },

            hls = {
                filetypes = {
                    "haskell",
                    "lhaskell",
                    "cabal",
                },
            },

            lua_ls = {
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
            },

            clangd = {
                keys = {
                    { "<leader>fh", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                },
            },

            pylsp = {
                settings = {
                    pylsp = {
                        plugins = {
                            mccabe = { enabled = false },
                            pycodestyle = { enabled = false },
                        },
                    },
                },
            },

            ts_ls = {
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = "/usr/lib/node_modules/@vue/typescript-plugin",
                            languages = { "javascript", "typescript", "vue" },
                        },
                    },
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                    "typescriptreact",
                },
            },

            texlab = {
                on_attach = function()
                    -- vim.o.wrap = true
                    vim.keymap.set("n", "<leader>lc", "<cmd>TexlabBuild<cr>", { desc = "Compile now" })
                    vim.keymap.set("n", "<leader>lo", "<cmd>TexlabForward<cr>", { desc = "Open pdf" })
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
            },

            bashls = {},
            jsonls = {},
            hyprls = {},
            rust_analyzer = {},
            taplo = {},
            cssls = {},
            marksman = {},
        },
    },

    config = function(_, opts)
        -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local lspconfig = require "lspconfig"
        for server, config in pairs(opts.servers) do
            -- passing config.capabilities to blink.cmp merges with the capabilities in your
            -- `opts[server].capabilities, if you've defined it
            config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                opts.buffer = ev.buf
                local opts = { noremap = true }

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
