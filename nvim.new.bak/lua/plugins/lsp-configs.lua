return {
    -- Mason: cài và quản lý LSP servers
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason-LSPConfig: tự động cài server cần thiết
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
            ensure_installed = {
                "pylsp",      -- Python
                "clangd",     -- C/C++
                "ts_ls",   -- TypeScript/JavaScript
                "tailwindcss",-- ✅ có dấu phẩy ở đây
                "html",       -- HTML
                "cssls",      -- CSS
                "emmet_ls",   -- ✅ Emmet server hợp lệ (tên đúng là emmet_ls)
            },
        },
    },

    -- LSPConfig: cấu hình server
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -----------------------------------------------------
            -- LSP cấu hình cho từng ngôn ngữ
            -----------------------------------------------------
            -- Lua
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

            -- Python
            vim.lsp.config["pylsp"] = {
                capabilities = capabilities,
            }

            -- C/C++
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

            -----------------------------------------------------
            -- 🌐 Web Development: HTML / CSS / JS / Tailwind / Emmet
            -----------------------------------------------------
            vim.lsp.config["html"] = {
                cmd = { "vscode-html-language-server", "--stdio" },
                capabilities = capabilities,
                filetypes = { "html" },
                root_dir = vim.fs.dirname(vim.fs.find({ ".git", "index.html", "package.json" }, { upward = true })[1]),
            }

            vim.lsp.config["cssls"] = {
                cmd = { "vscode-css-language-server", "--stdio" },
                capabilities = capabilities,
            }

            vim.lsp.config["ts_ls"] = {
                cmd = { "typescript-language-server", "--stdio" },
                capabilities = capabilities,
                settings = {
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                        },
                    },
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                        },
                    },
                },
            }

            vim.lsp.config["tailwindcss"] = {
                cmd = { "tailwindcss-language-server", "--stdio" },
                capabilities = capabilities,
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern("tailwind.config.js", ".git")(fname)
                end,
            }

            vim.lsp.config["emmet_ls"] = {
                capabilities = capabilities,
                filetypes = {
                    "html",
                    "css",
                    "javascriptreact",
                    "typescriptreact",
                    "vue",
                },
            }

            -----------------------------------------------------
            -- Khởi tạo tất cả server đã cài qua mason-lspconfig
            -----------------------------------------------------
            require("mason-lspconfig").setup_handlers({
                function(server)
                    local config = vim.lsp.config[server]
                    if config then
                        vim.lsp.start(config)
                    end
                end,
            })

            -----------------------------------------------------
            -- Keymaps tiện dụng cho LSP
            -----------------------------------------------------
            local map = vim.keymap.set
            map("n", "K", vim.lsp.buf.hover, {})
            map("n", "gi", vim.lsp.buf.implementation, {})
            map("n", "gd", vim.lsp.buf.definition, {})
            map("n", "gD", vim.lsp.buf.declaration, {})
            map("n", "gr", vim.lsp.buf.references, {})
            map("n", "<leader>rn", vim.lsp.buf.rename, {})
            map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

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

    -----------------------------------------------------
    -- ✨ Plugin phụ trợ cho Web Development
    -----------------------------------------------------
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "windwp/nvim-autopairs", config = true },
    { "norcalli/nvim-colorizer.lua", config = true },
    { "numToStr/Comment.nvim", config = true },

    -- Format và lint code (Prettier, ESLint)
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("none-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.diagnostics.eslint_d,
                },
            })
        end,
    },
}

