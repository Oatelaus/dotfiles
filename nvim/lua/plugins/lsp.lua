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
		"yamlls",
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


			for _, language in pairs(masonConfig.ensure_installed) do
				lspconfig[language].setup({})
			end

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
