-- Minimal neovim config

vim.opt.winborder = "rounded"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.o.expandtab = true

vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = true
vim.opt.undofile = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.hlsearch = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "<leader>p", '"+p')
map({ "n" }, "<leader>bk", ":bd<CR>")

-- Disable automatic rust_analyzer startup (rustaceanvim will handle it)
vim.g.rustaceanvim = vim.g.rustaceanvim or {}

-- Block Neovim from auto-starting rust_analyzer
vim.lsp.config("rust_analyzer", {
	-- Set empty root_dir function so it never matches
	root_dir = function()
		return nil
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- Stop any rust_analyzer without proper settings (auto-started by nvim)
		if client and client.name == "rust_analyzer" and vim.tbl_isempty(client.config.settings or {}) then
			vim.lsp.stop_client(client.id, true)
		end
	end,
})

require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"vimdoc",
					"javascript",
					"typescript",
					"c",
					"lua",
					"rust",
					"jsdoc",
					"bash",
					"elixir",
				},
				auto_install = true,
				indent = {
					enable = true,
				},

				highlight = {
					enable = true,
				},
			})
		end,
	},
	{
		"sainnhe/everforest",
		config = function()
			vim.cmd.colorscheme("everforest")
		end,
	},
	{
		"folke/flash.nvim",
		config = function()
			vim.keymap.set("n", "s", function()
				require("flash").jump()
			end)
			vim.keymap.set("n", "S", function()
				require("flash").treesitter_search()
			end)
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		version = "^18.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			adapters = {
				http = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							env = {
								url = "http://172.16.110.32:11434",
							},
							headers = {
								["Content-Type"] = "application/json",
							},
							parameters = {
								sync = true,
							},
							schema = {
								model = {
									default = "qwen2.5-coder:7b",
								},
							},
						})
					end,
				},
			},
			interactions = {
				chat = {
					adapter = "ollama",
					-- model = "qwen3:4b",
					keymaps = {
						send = {
							modes = { n = "<C-l>", i = "<C-s>" },
							opts = {},
						},
						close = {
							modes = { n = "<C-c>", i = "<C-c>" },
							opts = {},
						},
					},
				},
				inline = {
					adapter = "ollama",
				},
			},
			opts = {
				log_level = "DEBUG",
			},
		},
	},
	{
		"milanglacier/minuet-ai.nvim",
		opts = {
			provider = "openai_fim_compatible",
			n_completions = 1,
			context_window = 4096,
			provider_options = {
				openai_fim_compatible = {
					api_key = "TERM",
					name = "Ollama",
					end_point = "http://172.16.110.32:11434/v1/completions",
					model = "qwen2.5-coder:1.5b",
					-- model = "hf.co/lmstudio-community/zeta-GGUF:Q3_K_L",
					optional = {
						max_tokens = 48,
						top_p = 0.8,
					},
				},
			},
			virtualtext = {
				auto_trigger_ft = { "rust", "toml" },
				keymap = {
					accept = "<A-l>",
					accept_line = "<A-ö>",
					dismiss = "<A-k>",
				},
			},
			request_timeout = 10,
			blink = {
				enable_auto_complete = true,
			},
		},
	},
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "default",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
			},
			fuzzy = {
				implementation = "prefer_rust",
				prebuilt_binaries = {
					force_version = "v1.7.0",
					download = true,
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					toml = { "taplo" },
					lua = { "stylua" },
					rust = { "rustfmt" },
				},
			})

			-- Manual format keybind
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format buffer" })

			-- Format on save for all file types
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf, lsp_fallback = true })
				end,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",

			"https://github.com/natecraddock/telescope-zf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",

			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			"nvim-telescope/telescope-frecency.nvim",
			"https://github.com/LinArcX/telescope-env.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
						},
					},
					color_devicons = true,
					sorting_strategy = "ascending",
					path_displays = { "smart" },
					layout_config = {
						horizontal = {
							height = 50,
							width = 200,
							preview_width = 0.4,
							prompt_position = "top",
							preview_cutoff = 40,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							layout_config = {
								width = 0.8,
								height = 0.6,
							},
						}),
					},
					["zf-native"] = {},
					frecency = {
						auto_validate = true,
						show_scores = false,
						matcher = "fuzzy",
					},
				},
			})

			require("telescope").load_extension("zf-native")
			require("telescope").load_extension("frecency")
			require("telescope").load_extension("ui-select")

			local map = vim.keymap.set
			local builtin = require("telescope.builtin")

			map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })

			map("n", "<leader>.", builtin.find_files, { desc = "[S]earch [F]iles" })
			map("n", "<leader>,", ":Telescope frecency<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
			map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			map({ "n" }, "<leader>g", builtin.live_grep)
			map({ "n" }, "<leader>sb", builtin.buffers)

			map({ "n" }, "<leader>so", builtin.oldfiles)

			map({ "n" }, "<leader>sh", builtin.help_tags)
			map({ "n" }, "<leader>sm", builtin.man_pages)

			map("n", "<leader>sgb", builtin.git_bcommits)
			map("n", "<leader>sgg", builtin.git_files)
			map("n", "<leader>sgc", builtin.git_commits)
			map("n", "<leader>sgs", builtin.git_status)

			map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")
		end,
	},
	{
		"https://github.com/windwp/nvim-autopairs",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({
				signs = true,
				sign_priority = 8,
				keywords = {
					FIX = {
						icon = " ",
						color = "error",
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
					},
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					GEN = { icon = "G", alt = { "GENERATED", "AGENT" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
					SAFETY = { icon = "S", color = "hint", alt = { "Safety" } },
				},
				merge_keywords = true,
			})
			vim.keymap.set(
				"n",
				"<leader>td",
				":TodoTelescope layout_config={width=0.95,preview_width=0.3}<CR>",
				{ desc = "Telescope TODO viewer" }
			)
			vim.keymap.set("n", "<leader>tf", ":TodoQuickFix<CR>", { desc = " Quickfix TODO viewer" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"L3MON4D3/LuaSnip",
			"j-hui/fidget.nvim",
			"chrisgrieser/nvim-lsp-endhints",
		},
		config = function()
			require("lsp-endhints").setup({})
			require("fidget").setup({})
			require("mason").setup()

			-- Configure lua_ls with vim.lsp.config
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- Configure elixirls
			vim.lsp.config("elixirls", {})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"elixirls",
				},
				handlers = {
					function(server_name)
						-- Skip rust_analyzer as it's handled by rustaceanvim
						if server_name == "rust_analyzer" then
							return
						end
						-- Enable the LSP via vim.lsp.enable
						vim.lsp.enable(server_name)
					end,
					["rust_analyzer"] = function()
						-- Explicitly do nothing for rust_analyzer
					end,
				},
			})
			autocmd("LspAttach", {
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local bufnr = ev.buf

					-- Skip if this is rust_analyzer (handled by rustaceanvim)
					if client and client.name == "rust_analyzer" then
						-- Rustaceanvim sets up its own keybindings
						return
					end

					local builtin = require("telescope.builtin")

					map({ "n" }, "<leader>sd", function()
						builtin.diagnostics({
							layout_config = {
								width = 0.95,
								preview_width = 0.25,
							},
						})
					end, { desc = "[S]earch [D]iagnostics", buffer = bufnr })

					map({ "n" }, "gd", require("telescope.builtin").lsp_definitions, { buffer = bufnr })
					map({ "n" }, "gD", vim.lsp.buf.declaration, { buffer = bufnr })
					map(
						{ "n" },
						"gt",
						require("telescope.builtin").lsp_type_definitions,
						{ buffer = bufnr, desc = "Goto Type Definition" }
					)
					map({ "n" }, "gr", require("telescope.builtin").lsp_references, { buffer = bufnr })
					map({ "n" }, "gi", require("telescope.builtin").lsp_implementations, { buffer = bufnr })

					map(
						{ "n" },
						"<leader>ss",
						builtin.lsp_document_symbols,
						{ desc = "Search document symbols", buffer = bufnr }
					)
					map(
						{ "n" },
						"<leader>sS",
						builtin.lsp_dynamic_workspace_symbols,
						{ desc = "Search workspace symbols", buffer = bufnr }
					)

					map({ "n" }, "<leader>sr", builtin.lsp_references, { buffer = bufnr })
					map({ "n" }, "<leader>si", builtin.lsp_implementations, { buffer = bufnr })
					map({ "n" }, "<leader>st", builtin.lsp_type_definitions, { buffer = bufnr })

					map({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
					map({ "n" }, "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr })
				end,
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			position = "bottom",
			height = 10,
			mode = "workspace_diagnostics",
			fold_open = "",
			fold_closed = "",
			signs = {
				error = "",
				warning = "",
				hint = "",
				information = "",
			},
			focus = true,
		},
		cmd = "Trouble",
		keys = {
			-- Toggle trouble list with all project diagnostics
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			-- Toggle trouble list with buffer diagnostics only
			{
				"<leader>xb",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			-- Show only errors in the project
			{
				"<leader>xe",
				"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>",
				desc = "Errors (Trouble)",
			},
			-- Show errors and warnings in the project
			{
				"<leader>xw",
				"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<cr>",
				desc = "Errors & Warnings (Trouble)",
			},
			-- Jump to diagnostic at current line
			{
				"<leader>xl",
				"<cmd>Trouble diagnostics toggle focus=true filter.buf=0 filter={range={start={line=vim.fn.line('.')}}}<cr>",
				desc = "Line Diagnostics (Trouble)",
			},
			{
				"<leader>xl",
				vim.diagnostic.open_float,
				desc = "Line Diagnostics (Hover)",
			},
			-- Close trouble list
			{
				"<leader>xc",
				"<cmd>Trouble close<cr>",
				desc = "Close Trouble",
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		ft = { "rust" },
		init = function()
			vim.g.rustaceanvim = {
				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
				-- DAP configuration - rustaceanvim handles everything automatically
				-- Just need codelldb installed via Mason
				server = {
					on_attach = function(client, bufnr)
						local builtin = require("telescope.builtin")

						-- Rust-specific keybindings
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { buffer = bufnr, desc = "Code Action" })

						vim.keymap.set("n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { buffer = bufnr, desc = "Hover Actions" })

						vim.keymap.set("n", "<leader>rd", function()
							vim.cmd.RustLsp("debuggables")
						end, { buffer = bufnr, desc = "Rust Debuggables" })

						vim.keymap.set("n", "<leader>rD", function()
							-- Debug the test/target at cursor position
							vim.cmd.RustLsp("debug")
						end, { buffer = bufnr, desc = "Debug Test Under Cursor" })

						vim.keymap.set("n", "<leader>rr", function()
							vim.cmd.RustLsp("runnables")
						end, { buffer = bufnr, desc = "Rust Runnables" })

						vim.keymap.set("n", "<leader>rt", function()
							vim.cmd.RustLsp("testables")
						end, { buffer = bufnr, desc = "Rust Testables" })

						vim.keymap.set("n", "<leader>re", function()
							vim.cmd.RustLsp("expandMacro")
						end, { buffer = bufnr, desc = "Expand Macro" })

						vim.keymap.set("n", "<leader>rc", function()
							vim.cmd.RustLsp("openCargo")
						end, { buffer = bufnr, desc = "Open Cargo.toml" })

						vim.keymap.set("n", "<leader>rp", function()
							vim.cmd.RustLsp("parentModule")
						end, { buffer = bufnr, desc = "Parent Module" })

						vim.keymap.set("n", "<leader>rj", function()
							vim.cmd.RustLsp("joinLines")
						end, { buffer = bufnr, desc = "Join Lines" })

						-- Standard LSP keybindings for Rust
						vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = bufnr })
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
						vim.keymap.set(
							"n",
							"gt",
							builtin.lsp_type_definitions,
							{ buffer = bufnr, desc = "Goto Type Definition" }
						)
						vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = bufnr })
						vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = bufnr })

						vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr })
					end,
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
							checkOnSave = true,
							check = {
								allFeatures = true,
								command = "check", -- Use cargo check instead of clippy
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
			}
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				commented = false,
				only_first_definition = true,
				all_references = false,
				filter_references_pattern = "<module",
				virt_text_pos = "eol",
				all_frames = false,
				virt_lines = false,
				virt_text_win_col = nil,
			})

			dapui.setup({
				icons = { expanded = "", collapsed = "", current_frame = "" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 60, -- Increased from 40 to 60 columns
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					element = "repl",
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil,
					max_value_lines = 100,
				},
			})

			-- Auto-open and close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- DAP keybindings
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>dX", function()
				dap.clear_breakpoints()
				vim.notify("All breakpoints cleared", vim.log.levels.INFO)
			end, { desc = "Clear All Breakpoints" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue/Start Debugging" })
			vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
			vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
			vim.keymap.set("n", "<leader>ds", dap.session, { desc = "Show Session" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
			vim.keymap.set("n", "<leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Hover Variables" })
			vim.keymap.set("n", "<leader>dS", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "Scopes" })
			vim.keymap.set("n", "<leader>dl", function()
				vim.cmd("edit " .. vim.fn.stdpath("cache") .. "/dap.log")
			end, { desc = "Open DAP Log" })
			vim.keymap.set("n", "<leader>dw", function()
				local expr = vim.fn.input("Watch expression: ")
				if expr ~= "" then
					dapui.elements.watches.add(expr)
				end
			end, { desc = "Add Watch" })

			-- Quick jump to DAP UI panels (focus actual sidebar/bottom panels)
			local function focus_dap_window(element_name)
				-- Find the window showing this element using filetype
				local ft_map = {
					Scopes = "dapui_scopes",
					Breakpoints = "dapui_breakpoints",
					Stacks = "dapui_stacks",
					Watches = "dapui_watches",
					Repl = "dapui_repl",
					Console = "dapui_console",
				}

				local target_ft = ft_map[element_name]
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.bo[buf].filetype
					if ft == target_ft then
						vim.api.nvim_set_current_win(win)
						return
					end
				end
				vim.notify("DAP UI panel '" .. element_name .. "' not found. Is DAP UI open?", vim.log.levels.WARN)
			end

			vim.keymap.set("n", "<leader>d1", function()
				focus_dap_window("Scopes")
			end, { desc = "Focus Scopes Panel" })
			vim.keymap.set("n", "<leader>d2", function()
				focus_dap_window("Breakpoints")
			end, { desc = "Focus Breakpoints Panel" })
			vim.keymap.set("n", "<leader>d3", function()
				focus_dap_window("Stacks")
			end, { desc = "Focus Call Stack Panel" })
			vim.keymap.set("n", "<leader>d4", function()
				focus_dap_window("Watches")
			end, { desc = "Focus Watches Panel" })
			vim.keymap.set("n", "<leader>d5", function()
				focus_dap_window("Repl")
			end, { desc = "Focus REPL Panel" })
			vim.keymap.set("n", "<leader>d6", function()
				focus_dap_window("Console")
			end, { desc = "Focus Console Panel" })
		end,
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { "filename", "branch", "diff" },
				lualine_c = {
					"%=",
				},
				lualine_x = {},
				lualine_y = { "filetype", "progress" },
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				hint = "floating-big-letter",
				show_prompt = false,
				filter_rules = {
					bo = {
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						buftype = { "terminal", "quickfix" },
					},
				},
			})

			-- Easy window picker keybind
			vim.keymap.set("n", "<leader>w", function()
				local picked_window_id = require("window-picker").pick_window()
				if picked_window_id then
					vim.api.nvim_set_current_win(picked_window_id)
				end
			end, { desc = "Pick a window" })

			-- Also keep - as an alternative for easy access
			vim.keymap.set("n", "-", function()
				local picked_window_id = require("window-picker").pick_window()
				if picked_window_id then
					vim.api.nvim_set_current_win(picked_window_id)
				end
			end, { desc = "Pick a window" })
		end,
	},
})
