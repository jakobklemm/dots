require('gitsigns').setup {
    signcolumn = true,
    current_line_blame = true,
    current_line_blame_opts = {
       delay = 1250,
    },
    attach_to_untracked = true, 
    preview_config = {
        style = 'minimal',
    }
}
