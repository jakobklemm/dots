-- Minimal neovim config

vim.opt.winborder = "rounded"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.o.expandtab = true

vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = true
vim.opt.undofile = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.hlsearch = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

map({ "n", "v" }, "<leader>y", "\"+y")
map({ "n", "v" }, "<leader>p", "\"+p")
map({ "n" }, "<leader>bk", ":bd<CR>")

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc",
                    "javascript",
                    "typescript",
                    "c",
                    "lua",
                    "rust",
                    "jsdoc",
                    "bash",
                    "elixir",
                },
                auto_install = true,
                indent = {
                    enable = true,
                },

                highlight = {
                    enable = true,
                }
            })
        end,
    },
    {
        "sainnhe/everforest",
        config = function()
            vim.cmd.colorscheme("everforest")
        end,
    },
    {
        "folke/flash.nvim",
        config = function()
            vim.keymap.set("n", "s", function() require("flash").jump() end)
            vim.keymap.set("n", "S", function() require("flash").treesitter_search() end)
        end,
    },
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                preset = 'default',
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
            },
            fuzzy = {
                implementation = "prefer_rust",
                prebuilt_binaries = {
                    force_version = 'v1.7.0',
                    download = true,
                },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",

            "https://github.com/natecraddock/telescope-zf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",

            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
            "nvim-telescope/telescope-frecency.nvim",
            "https://github.com/LinArcX/telescope-env.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        },
                    },
                    color_devicons = true,
                    sorting_strategy = "ascending",
                    path_displays = { "smart" },
                    layout_config = {
                        height = 50,
                        width = 200,
                        preview_width = 0.4,
                        prompt_position = "top",
                        preview_cutoff = 40,
                    }
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                    ["zf-native"] = {},
                    frecency = {
                        auto_validate = true,
                        show_scores = false,
                        matcher = "fuzzy",
                    },
                },
            })

            require("telescope").load_extension("zf-native")
            require("telescope").load_extension("frecency")

            local map = vim.keymap.set
            local builtin = require("telescope.builtin")

            map(
                "n",
                "<leader>/",
                builtin.current_buffer_fuzzy_find,
                { desc = "[/] Fuzzily search in current buffer" }
            )

            map("n", "<leader>.", builtin.find_files, { desc = "[S]earch [F]iles" })
            map("n", "<leader>,", ":Telescope frecency<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
            map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

            map({ "n" }, "<leader>g", builtin.live_grep)
            map({ "n" }, "<leader>sb", builtin.buffers)

            map({ "n" }, "<leader>so", builtin.oldfiles)

            map({ "n" }, "<leader>sh", builtin.help_tags)
            map({ "n" }, "<leader>sm", builtin.man_pages)

            map("n", "<leader>sgb", builtin.git_bcommits)
            map("n", "<leader>sgg", builtin.git_files)
            map("n", "<leader>sgc", builtin.git_commits)
            map("n", "<leader>sgs", builtin.git_status)


            map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")
        end
    },
    {
        "https://github.com/windwp/nvim-autopairs",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup({})
            vim.keymap.set("n", "<leader>td", ":TodoTelescope layout_config={width=0.95,preview_width=0.3}<CR>",
                { desc = "Telescope TODO viewer" })
            vim.keymap.set("n", "<leader>tf", ":TodoQuickFix<CR>", { desc = " Quickfix TODO viewer" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "L3MON4D3/LuaSnip",
            "j-hui/fidget.nvim",
            "chrisgrieser/nvim-lsp-endhints",
        },
        config = function()
            require("lsp-endhints").setup({})
            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "elixirls",
                },
            })
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" } }
                    }
                }
            })
            autocmd("LspAttach", {
                callback = function(ev)
                    local builtin = require('telescope.builtin')

                    map({ "n" }, "<leader>sd", function()
                        builtin.diagnostics({
                            layout_config = {
                                width = 0.95,
                                preview_width = 0.25,
                            }
                        })
                    end, { desc = "[S]earch [D]iagnostics" })

                    map({ "n" }, "gd", require("telescope.builtin").lsp_definitions)
                    map({ "n" }, "gD", vim.lsp.buf.declaration)
                    map({ "n" }, "gr", require("telescope.builtin").lsp_references)
                    map({ "n" }, "gi", require("telescope.builtin").lsp_implementations)

                    map({ "n" }, "<leader>ss", builtin.lsp_document_symbols, { desc = "Search document symbols" })
                    map({ "n" }, "<leader>sS", builtin.lsp_dynamic_workspace_symbols,
                        { desc = "Search workspace symbols" })

                    map({ "n" }, "<leader>sr", builtin.lsp_references)
                    map({ "n" }, "<leader>si", builtin.lsp_implementations)
                    map({ "n" }, "<leader>st", builtin.lsp_type_definitions)

                    map({ "n" }, "<leader>ca", vim.lsp.buf.code_action)
                    map({ "n" }, "<leader>cr", vim.lsp.buf.rename)

                    map({ "n" }, "<leader>w", function()
                        vim.lsp.buf.format()
                        vim.cmd('write')
                    end)
                end,

            })
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            position = "bottom",
            height = 10,
            mode = "workspace_diagnostics",
            fold_open = "",
            fold_closed = "",
            signs = {
                error = "",
                warning = "",
                hint = "",
                information = "",
            },
            focus = true,
        },
        cmd = "Trouble",
        keys = {
            -- Toggle trouble list with all project diagnostics
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            -- Toggle trouble list with buffer diagnostics only
            {
                "<leader>xb",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            -- Show only errors in the project
            {
                "<leader>xe",
                "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>",
                desc = "Errors (Trouble)",
            },
            -- Show errors and warnings in the project
            {
                "<leader>xw",
                "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<cr>",
                desc = "Errors & Warnings (Trouble)",
            },
            -- Jump to diagnostic at current line
            {
                "<leader>xl",
                "<cmd>Trouble diagnostics toggle focus=true filter.buf=0 filter={range={start={line=vim.fn.line('.')}}}<cr>",
                desc = "Line Diagnostics (Trouble)",
            },
            {
                "<leader>xl",
                vim.diagnostic.open_float,
                desc = "Line Diagnostics (Hover)",
            },
            -- Close trouble list
            {
                "<leader>xc",
                "<cmd>Trouble close<cr>",
                desc = "Close Trouble",
            },
        },
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",

            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { 'filename', 'branch', 'diff' },
                lualine_c = {
                    '%='
                },
                lualine_x = {},
                lualine_y = { 'filetype', 'progress' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
            },
            tabline = {},
            extensions = {},
        }
    },
})
