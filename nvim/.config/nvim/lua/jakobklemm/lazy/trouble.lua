return {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>tt",
            "<cmd>Trouble toggle<cr>",
            desc = "Trouble Toggle",
        },
        {
            "<leader>tb",
            "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR> filter.severity=vim.diagnostic.severity.ERROR",
            desc = "Buffer Diagnostics (Trouble)",
        },
    },
}
