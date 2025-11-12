-- Minimal neovim config

vim.opt.winborder = "rounded"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.showtabline = 4
vim.o.expandtab = true

vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true

vim.opt.termguicolors = true
vim.opt.undofile = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.hlsearch = true

vim.pack.add({
    { src = "https://github.com/sainnhe/everforest" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },

    { src = "https://github.com/nvim-telescope/telescope.nvim",          version = "0.1.8" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/natecraddock/telescope-zf-native.nvim" },

    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/aznhe21/actions-preview.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",        version = "main" },

    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/windwp/nvim-autopairs" },

    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/LinArcX/telescope-env.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
})

local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

vim.cmd.colorscheme("everforest")

require("blink.cmp").setup({
    fuzzy = { 
        implementation = "prefer_rust",
        prebuilt_binaries = {
            download = true,
        },
    },
    keymap = {
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
    }
})

require("fidget").setup()
require("mason").setup()
require("nvim-autopairs").setup()

vim.lsp.enable({
    "lua_ls", "rust_analyzer",
})


autocmd("LspAttach", {
    callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        vim.keymap.set("n", "<leader>sd", function()
            require("telescope.builtin").diagnostics({
                layout_config = {
                    width = 0.95,  
                    preview_width = 0.25, 
                }
            })
        end, { desc = "[S]earch [D]iagnostics" })

        local builtin = require('telescope.builtin')

        map({ "n" }, "<leader>si", builtin.lsp_implementations)
        map({ "n" }, "<leader>st", builtin.lsp_type_definitions)

        map({ "n" }, "<leader>w", function()
            vim.lsp.buf.format()
            vim.cmd('write')
        end)
    end,

})

require("flash").setup({})
vim.keymap.set("n", "s", function() require("flash").jump() end)
vim.keymap.set("n", "S", function() require("flash").treesitter_search() end)

require("todo-comments").setup({})
vim.keymap.set("n", "<leader>td", ":TodoTelescope layout_config={width=0.95,preview_width=0.3}<CR>", { desc = "Telescope TODO viewer" })
vim.keymap.set("n", "<leader>tf", ":TodoQuickFix<CR>", { desc = " Quickfix TODO viewer" })

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<c-enter>"] = "to_fuzzy_refine",
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
        },
        preview = {
            treesitter = false,
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
        ["zf-native"] = {}
    },
})

require("telescope").load_extension("zf-native")

local builtin = require("telescope.builtin")

map({ "n", "v" }, "<leader>y", "\"+y")
map({ "n", "v" }, "<leader>p", "\"+p")
map({ "n" }, "<leader>bk", ":bd<CR>")

vim.keymap.set(
    "n",
    "<leader>/",
    builtin.current_buffer_fuzzy_find,
    { desc = "[/] Fuzzily search in current buffer" }
)
vim.keymap.set("n", "<leader>.", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>,", ":Telescope frecency<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

map({ "n" }, "<leader>g", builtin.live_grep)
map({ "n" }, "<leader>sg", builtin.git_files)
map({ "n" }, "<leader>sb", builtin.buffers)

map({ "n" }, "<leader>so", builtin.oldfiles)

map({ "n" }, "<leader>sh", builtin.help_tags)
map({ "n" }, "<leader>sm", builtin.man_pages)

map({ "n" }, "<leader>sr", builtin.lsp_references)



map({ "n" }, "<leader>sc", builtin.git_bcommits)

map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")
map({ "n" }, "<leader>sa", require("actions-preview").code_actions)

map({ "n" }, "<M-n>", "<cmd>resize +2<CR>")
map({ "n" }, "<M-e>", "<cmd>resize -2<CR>")
map({ "n" }, "<M-i>", "<cmd>vertical resize +5<CR>")
map({ "n" }, "<M-m>", "<cmd>vertical resize -5<CR>")

map({ "n" }, "<leader>w", "<Cmd>update<CR>", { desc = "Write the current buffer." })
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })

map({ "n" }, "<C-f>", "<Cmd>Open .<CR>", { desc = "Open current directory in Finder." })
