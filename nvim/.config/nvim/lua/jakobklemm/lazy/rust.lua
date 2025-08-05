return {
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },

    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
        end,
    },

    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
        dependencies = {
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
            "saghen/blink.cmp",
        },
        ft = "rust",
        config = function()
            require("fidget").setup({})

            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {},
                -- LSP configuration
                server = {
                    on_attach = function(client, bufnr)
                        local map = function(keys, func, desc, mode)
                            mode = mode or "n"
                            vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
                        end

                        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                        map("gD", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
                        map("g.", vim.lsp.buf.code_action, "Code action", { "n", "x" })

                        map("gw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                        map("ge", "<cmd>RustLsp explainError current<CR>", "Cycle [E]xplain [E]rror")

                        vim.keymap.set(
                            "n",
                            "<leader>q",
                            vim.diagnostic.setloclist,
                            { desc = "Open diagnostic [Q]uickfix list" }
                        )
                    end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            capabilities = require("blink.cmp").get_lsp_capabilities(),
                        },
                    },
                },
                dap = {},
            }
        end,
    },

    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {},
    },

    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
}
