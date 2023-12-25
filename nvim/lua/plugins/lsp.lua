local masonConfig = {
	ensure_installed = {
		"astro",
		"cssls",
		"html",
		"jsonls",
		"lua_ls",
		"marksman",
		"vtsls",
		"rust_analyzer",
		"yamlls"
	}
}

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require('mason').setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup(masonConfig)
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require('lspconfig')

			-- Setup default LSPs
			lspconfig.lua_ls.setup({})
			lspconfig.vtsls.setup({})
			lspconfig.astro.setup({})
			lspconfig.cssls.setup({})
			lspconfig.html.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.marksman.setup({})
			lspconfig.vtsls.setup({})
			lspconfig.rust_analyzer.setup({})
			lspconfig.yamlls.setup({})

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function()
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
					vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'View code actions' })
				end,
			})
		end
	}
}
