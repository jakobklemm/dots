-- Dreams Of Code YT
-- https://github.com/dreamsofcode-io/neovim-rust/blob/main/configs/rust-tools.lua

local rt = require('rust-tools')

local mason_registry = require("mason-registry")

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

rt.setup({
      dap = {
	 adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      },
      server = {
	 on_attach = function(_, bufrn)
	    local nmap = function(keys, func, desc)
	       if desc then
		  desc = 'LSP: ' .. desc
	       end
	       
	       vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	    end

	 nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	 -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	 nmap('<leader>ca', rt.code_action_group.code_action_group, '[C]ode [A]ction')
	 nmap('<leader>ch', rt.hover_actions.hover_actions, '[C]ode [H]over')

	 nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	 nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	 nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
	 nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	 nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	 nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	 -- See `:help K` for why this keymap
	 nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	 nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	 vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
						 vim.lsp.buf.format()
	 end, { desc = 'Format current buffer with LSP' })
   
	 end,
      },
      tools = {
	 inlay_hints = {
	    auto = true,
	    -- only_current_line = true,
	 },
	 hover_actions = {
	    auto_focus = true,
	 },
      }
			   })

