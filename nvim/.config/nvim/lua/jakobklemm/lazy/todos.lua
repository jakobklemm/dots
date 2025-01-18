return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup({})
            vim.keymap.set("n", "<leader>td", ":TodoTelescope<CR>", { desc = "[ ] Todos [ ] Telescope" })
            vim.keymap.set("n", "<leader>tf", ":TodoQuickFix<CR>", { desc = "[ ] Todos [ ] Quickfix" })
        end,
    },
}
