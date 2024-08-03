return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local mason_tool_installer = require("mason-tool-installer")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            mason.setup({})

            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "pbls",
                },
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "gofumpt",
                    "delve",
                    "goimports",
                    "stylua",
                    "golangci-lint",
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    opts.desc = "LSP: Show references"
                    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

                    opts.desc = "LSP: Go to declaration"
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                    opts.desc = "LSP: Go to definition"
                    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                    opts.desc = "LSP: Hover"
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                    opts.desc = "LSP: Go to implementation"
                    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                    opts.desc = "LSP: Code actions"
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    opts.desc = "LSP: Rename"
                    vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)

                    opts.desc = "LSP: Show buffer diagnostics"
                    vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                    opts.desc = "LSP: Show line diagnostics"
                    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                end,
            })

            -- Set borders on LSP hovers
            -- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
            -- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])
            --
            -- local border = {
            -- 	{ "🭽", "FloatBorder" },
            -- 	{ "▔", "FloatBorder" },
            -- 	{ "🭾", "FloatBorder" },
            -- 	{ "▕", "FloatBorder" },
            -- 	{ "🭿", "FloatBorder" },
            -- 	{ "▁", "FloatBorder" },
            -- 	{ "🭼", "FloatBorder" },
            -- 	{ "▏", "FloatBorder" },
            -- }
            --
            -- -- Override borders globally for all LSPs
            -- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            -- 	opts = opts or {}
            -- 	opts.border = opts.border or border
            -- 	return orig_util_open_floating_preview(contents, syntax, opts, ...)
            -- end

            -- Setup some custom icons for diagnostic messages
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            mason_lspconfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            })
        end,
    },
}
