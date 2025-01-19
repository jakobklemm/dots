return {
    "huynle/ogpt.nvim",
    event = "VeryLazy",
    opts = {
        default_provider = "ollama",
        providers = {
            ollama = {
                api_host = "http://172.16.110.32:11434",
                api_key = "",
                model = "llama3.2:3b",
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
