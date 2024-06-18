return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        { 'antosha417/nvim-lsp-file-operations', config = true },
    },
    config = function()
        local lspconfig = require 'lspconfig'
        local cmp_nvim_lsp = require 'cmp_nvim_lsp'
        local opts = { noremap = true, silent = true }

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                opts.buffer = ev.buf

                opts.desc = 'Show LSP references'
                vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

                opts.desc = 'Go to declaration'
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

                opts.desc = 'Go to definitions'
                vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

                opts.desc = 'Go to type definitions'
                vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

                opts.desc = 'Smart rename'
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

                opts.desc = 'Show buffer diagnostics'
                vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

                opts.desc = 'Show line diagnostics'
                vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

                opts.desc = 'Show documentation for what is under the cursor'
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

                opts.desc = 'Restart LSP'
                vim.keymap.set('n', '<leader>rs', '<cmd>LspRestart<CR>', opts)
            end,
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
        for type, icon in pairs(signs) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
        end

        local servers = { 'clangd', 'basedpyright', 'bashls', 'dockerls', 'jsonls', 'markdown_oxide', 'mesonlsp', 'taplo', 'texlab', 'hyprls' }

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                capabilities = capabilities,
            }
        end

        lspconfig['clangd'].setup {
            capabilities = capabilities,
            keys = {
                { '<leader>fh', '<cmd>ClangdSwitchSourceHeader<cr>', desc = 'Switch Source/Header (C/C++)' },
            },
            format = {
                enabled = true,
                defaultConfig = {
                    indent_style = 'space',
                    indent_size = '4',
                },
            },
        }

        lspconfig.hyprls.setup {
            filetypes = { '*.hl', 'hypr*.conf', '.config/hypr/*.conf', 'hyprlang' },
        }

        lspconfig['lua_ls'].setup {
            capabilities = capabilities,
            settings = { -- custom settings for lua
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                            [vim.fn.stdpath 'config' .. '/lua'] = true,
                        },
                    },
                },
            },
        }

        lspconfig.texlab.setup {
            on_attach = function()
                opts.desc = 'Compile now'
                vim.keymap.set('n', '<leader>lc', '<cmd>TexlabBuild<cr>', opts)

                opts.desc = 'Open pdf'
                vim.keymap.set('n', '<leader>lo', '<cmd>TexlabForward<cr>', opts)

                vim.o.wrap = true
            end,
            settings = {
                texlab = {
                    bibtexFormatter = 'texlab',
                    build = {
                        args = { '-output-dir', 'builddir', '%f' },
                        executable = 'pdflatex',
                        forwardSearchAfter = false,
                        onSave = true,

                        auxDirectory = './builddir',
                        pdfDirectory = './builddir',
                        logDirectory = './builddir',
                    },
                    chktex = {
                        onEdit = true,
                        onOpenAndSave = true,
                    },

                    forwardSearch = {
                        executable = 'zathura',
                        args = {
                            '--synctex-editor-command',
                            [[nvim-texlabconfig -file '%%%{input}' -line %%%{line} -server ]] .. vim.v.servername,
                            '--synctex-forward',
                            '%l:1:%f',
                            '%p',
                        },
                    },
                    diagnosticsDelay = 300,
                    formatterLineLength = 80,
                },
            },
        }
    end,
}
