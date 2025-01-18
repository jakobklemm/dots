return {
    "echasnovski/mini.nvim",
    config = function()
        -- require("mini.ai").setup()
        -- require("mini.surround").setup()
        -- require("mini.operators").setup()
        require("mini.pairs").setup()
        -- require("mini.bracketed").setup()
        require("mini.files").setup()
        require("mini.comment").setup()
        require("mini.move").setup()
        require("mini.animate").setup({
            cursor = {
                enable = false,
            },
            scroll = {
                enable = true,
            },
            open = {
                enable = false,
            },
            close = {
                enable = false,
            },
        })

        vim.keymap.set("n", "<leader>mf", MiniFiles.open, { desc = "mini file browser" })
    end,
}
