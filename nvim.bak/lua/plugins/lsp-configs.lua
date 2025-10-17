return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
            ensure_installed = {
                --"zls",     -- Zig
                --"gopls",   -- Go
                "pylsp",   -- Python
                "clangd",  -- C/C++
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- Định nghĩa config cho từng server
            vim.lsp.config["lua_ls"] = {
                cmd = { "lua-language-server" },
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            vim.lsp.config["pylsp"] = {
                capabilities = capabilities,
            }

            vim.lsp.config["clangd"] = {
                cmd = { "clangd", "--header-insertion=never" },
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                    vim.keymap.set("n", "<leader>ih", function()
                        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
                    end, { buffer = bufnr, desc = "Toggle Inlay Hints" })
                end,
            }

            -- Nếu bạn dùng mason-lspconfig, tự start các server đã cài
            require("mason-lspconfig").setup_handlers({
                function(server)
                    local config = vim.lsp.config[server]
                    if config then
                        vim.lsp.start(config)
                    end
                end,
            })

            -- Keymap LSP
            local map = vim.keymap.set
            map("n", "K", vim.lsp.buf.hover, {})
            map("n", "gi", vim.lsp.buf.implementation, {})
            map("n", "gd", vim.lsp.buf.definition, {})
            map("n", "gD", vim.lsp.buf.declaration, {})
            map("n", "gr", vim.lsp.buf.references, {})
            map("n", "<leader>rn", vim.lsp.buf.rename, {})
            map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

            -- List methods (fzf-lua)
            map("n", "<leader>fm", function()
                local filetype = vim.bo.filetype
                local symbols_map = {
                    python = "function",
                    javascript = "function",
                    typescript = "function",
                    java = "class",
                    lua = "function",
                    go = { "method", "struct", "interface" },
                    c = { "function", "struct" },
                    cpp = { "function", "class", "struct" },
                    sh = "function",
                }
                local symbols = symbols_map[filetype] or "function"
                require("fzf-lua").lsp_document_symbols({ symbols = symbols })
            end, {})
        end,
    },
}

