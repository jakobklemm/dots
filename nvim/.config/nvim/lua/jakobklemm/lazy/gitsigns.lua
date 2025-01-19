-- https://github.com/omerxx/dotfiles/blob/master/nvim/lua/plugins/gitsigns.lua
return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            current_line_blame = false,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- TODO: Git Actions
                -- map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                -- map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                -- map("n", "<leader>hS", gs.stage_buffer)
                -- map("n", "<leader>ha", gs.stage_hunk)
                -- map("n", "<leader>hu", gs.undo_stage_hunk)
                -- map("n", "<leader>hR", gs.reset_buffer)
                -- map("n", "<leader>hp", gs.preview_hunk)
                -- <leader>go from snacks instead?
                -- map("n", "<leader>tb", function()
                --     gs.blame_line({ full = true })
                -- end, { desc = "full blame for current line" })
                map("n", "<leader>tB", gs.toggle_current_line_blame, { desc = "toggle git blame preview" })
                -- map("n", "<leader>hd", gs.diffthis)
                -- map("n", "<leader>hD", function()
                --     gs.diffthis("~")
                -- end)
            end,
        })
    end,
}
