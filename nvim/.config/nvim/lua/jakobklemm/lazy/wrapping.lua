return {
    "andrewferrier/wrapping.nvim",
    config = function()
        local w = require("wrapping")

        w.setup({ notify_on_switch = false })
        w.hard_wrap_mode()
    end,
}
