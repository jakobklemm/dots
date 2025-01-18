-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/lazy/zenmode.lua
return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup({
            window = {
                width = 0.80,
                options = {},
            },
            plugins = {
                options = {
                    enabled = true,
                },
                kitty = {
                    enabled = true,
                    -- TODO: maybe not working?
                    font = "+4",
                },
            },
        })

        vim.keymap.set("n", "<leader>zz", require("zen-mode").toggle)
    end,
}
