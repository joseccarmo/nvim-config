return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "arduino_language_server",
                    "asm_lsp",
                    "clangd",
                    "harper_ls",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    zls = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.zls.setup({
                            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                            settings = {
                                zls = {
                                    enable_inlay_hints = true,
                                    enable_snippets = true,
                                    warn_style = true,
                                },
                            },
                        })
                        vim.g.zig_fmt_parse_errors = 0
                        vim.g.zig_fmt_autosave = 0

                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")

                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = 'LuaJIT',
                                    },
                                    diagnostics = {
                                        globals = { 'vim' },
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = false,
                                    },
                                    format = {
                                        enable = true,
                                        -- Put format options here
                                        -- NOTE: the value should be STRING!!
                                        defaultConfig = {
                                            indent_style = "space",
                                            indent_size = "2",
                                        }
                                    },
                                }
                            }
                        }
                    end,
                    ["clangd"] = function()
                        require("lspconfig").clangd.setup({
                            capabilities = capabilities,
                            cmd = {
                                "clangd",
                                "--background-index",
                                "--offset-encoding=utf-16",
                            }
                        })
                    end,
                    ["arduino_language_server"] = function()
                        require("lspconfig").arduino_language_server.setup({
                            capabilities = capabilities,
                            cmd = {
                                "arduino-language-server",
                                "-cli", "/usr/bin/arduino-cli",
                                "-cli-config", "/home/duck/.arduino15/arduino-cli.yaml",
                                "-fqbn", "arduino:avr:mega",
                                "-clangd", "/usr/bin/clangd",
                            },
                        })
                    end,
                    ["asm_lsp"] = function()
                        require("lspconfig").asm_lsp.setup({
                            capabilities = capabilities,
                            filetypes = { "asm", "s", "S" },
                        })
                    end,
                    ["tailwindcss"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.tailwindcss.setup({
                            capabilities = capabilities,
                            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "heex" },
                        })
                    end,
                }
            })

            -- Harper-ls is system-installed, not Mason-managed.
            -- Set it up directly using the native vim.lsp.config API.
            vim.lsp.config["harper_ls"] = {
                cmd = { "harper-ls", "--stdio" },
                filetypes = { "markdown", "vimwiki" },
                get_language_id = function(bufnr, filetype)
                    if filetype == "vimwiki" then return "markdown" end
                    return filetype
                end,
                capabilities = capabilities,
                settings = {
                    ["harper-ls"] = {
                        linters = {
                            SpellCheck = true,
                            AnA = true,
                            SentenceCapitalization = true,
                            UnclosedQuotes = true,
                            LongSentences = true,
                            RepeatedWords = true,
                            Spaces = false,
                            CorrectNumberSuffix = true,
                        },
                        codeActions = {
                            ForceStable = false,
                        },
                        diagnosticSeverity = "warning",
                    },
                },
            }
            vim.lsp.enable("harper_ls")

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })

            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- Diagnostics
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.jump({ count = -1, float = true })
            end, { desc = "Previous diagnostic" })

            vim.keymap.set("n", "]d", function()
                vim.diagnostic.jump({ count = 1, float = true })
            end, { desc = "Next diagnostic" })

            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
                desc = "Show diagnostic under cursor",
            })

            vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, {
                desc = "Diagnostics to quickfix list",
            })
        end
    }
