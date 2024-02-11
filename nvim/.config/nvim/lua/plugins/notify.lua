local notify = require("notify") 

notify.setup({
	render = 'compact',
	on_open = function(win)
		vim.api.nvim_win_set_config(win, {focusable = false})
	end,
	stages = 'fade_in_slide_out',
	backgroud_color = 'FloatShadow'
})

vim.api.nvim_set_keymap("n", "<leader>p", "", {callback = notify.dismiss})

