return {
    {
        {
            "saghen/blink.compat",
            -- use v2.* for blink.cmp v1.*
            version = "2.*",
            -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
            lazy = true,
            -- make sure to set opts so that lazy.nvim calls blink.compat's setup
            opts = {},
        },

        {
            "saghen/blink.cmp",
            dependencies = {
                "rafamadriz/friendly-snippets",
                "huijiro/blink-cmp-supermaven",
            },

            version = "1.*",

            opts = {
                keymap = {
                    preset = "none",

                    ["<C-k>"] = { "select_prev" },
                    ["<C-j>"] = { "select_next" },

                    ["<C-y>"] = { "accept" },
                    ["<C-l>"] = { "accept" },

                    ["<C-e>"] = { "cancel" },
                    ["<C-x>"] = { "show" },

                    ["<C-s>"] = {
                        function(cmp)
                            cmp.show({ providers = { "snippets" } })
                        end,
                    },
                },

                appearance = {
                    nerd_font_variant = "mono",
                },

                completion = {
                    documentation = {
                        auto_show = true,
                        window = { border = "rounded" },
                    },
                    accept = {
                        auto_brackets = {
                            enabled = true,
                        },
                    },
                    menu = {
                        border = "rounded",
                    },
                },

                sources = {
                    default = {
                        "lsp",
                        "path",
                        "snippets",
                        "buffer",
                        "supermaven",
                    },
                    providers = {
                        supermaven = {
                            name = "supermaven",
                            module = "blink-cmp-supermaven",
                            async = true,
                        },
                    },
                },

                fuzzy = { implementation = "prefer_rust_with_warning" },
            },
            opts_extend = { "sources.default" },
        },
    },

    {
        "saghen/blink.indent",
        opts = {
            static = {
                highlight = "BlinkIndentViolet",
            },
        },
    },
}
