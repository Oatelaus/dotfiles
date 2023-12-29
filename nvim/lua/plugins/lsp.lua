local languages = {
	{
		language = "cssls"
	},
	{
		language = "html"
	},
	{
		language = "jsonls"
	},
	{
		language = "lua_ls",
		setup = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					}
				}
			}
		}
	},
	{
		language = "vtsls"
	},
	{
		language = "yamlls"
	},
}

local masonConfig = {
	-- Autofilled by the content of languages and the "language" key.
	ensure_installed = {}
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
			for _, config in ipairs(languages) do
				table.insert(masonConfig.ensure_installed, config.language)
			end

			require("mason-lspconfig").setup(masonConfig)
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require('lspconfig')


			for _, config in pairs(languages) do
				lspconfig[config.language].setup(config.setup or {})
			end

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function()
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
					vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'View code actions' })
					vim.keymap.set('n', 'cS', vim.lsp.buf.rename, { desc = 'Renames a symbol' })
				end,
			})
		end
	}
}
