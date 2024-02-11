local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
      "nyoom-engineering/oxocarbon.nvim",
      {
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},
	{
	   "folke/trouble.nvim",
	   dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
	   "rust-lang/rust.vim",
	   ft = "rust",
	   init = function()
	      vim.g.rustfmt_autosave = 1
	   end
	},
	{
	   "simrat39/rust-tools.nvim",
	   dependencies = { "neovim/nvim-lspconfig" },
	},
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"lewis6991/gitsigns.nvim",
	"rmagatti/goto-preview",
	{
	   "windwp/nvim-autopairs",
	   opts = {},
	},
	{
	   "folke/noice.nvim",
	   config = function()
	      require("noice").setup({
				    })
	   end,
	   dependencies = {
	      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	      "MunifTanjim/nui.nvim",
	      -- OPTIONAL:
	      --   `nvim-notify` is only needed, if you want to use the notification view.
	      --   If not available, we use `mini` as the fallback
	      "rcarriga/nvim-notify",
	   }
	},

	"nvim-lualine/lualine.nvim",
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},
	{ "numToStr/Comment.nvim", opts = {} },
	{ "folke/which-key.nvim", opts = {} },

	-- Experimental
	{
		"nomnivore/ollama.nvim",

		opts = {
			model = "mistral:instruct",
			url = "https://ollama.local.jeykey.net"
		}
	}
}, {})
