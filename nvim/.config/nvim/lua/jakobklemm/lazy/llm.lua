return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        adapters = {
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "http://172.16.110.32:11434",
                    },
                    parameters = {
                        sync = true,
                    },
                    schema = {
                        model = {
                            -- default = "llama3.2:3b",
                            -- default = "llama3.1:latest",
                            default = "codellama:latest",
                        },
                    },
                })
            end,
        },
        strategies = {
            chat = {
                adapter = "ollama",
                keymaps = {
                    send = {
                        modes = {
                            n = "<C-x>",
                            i = "<C-x>",
                        },
                    },
                    close = {
                        modes = {
                            n = "<C-c>",
                            i = "<C-c>",
                        },
                    },
                },
            },
            inline = {
                adapter = "ollama",
            },
            cmd = {
                adapter = "ollama",
            },
        },
    },
}
