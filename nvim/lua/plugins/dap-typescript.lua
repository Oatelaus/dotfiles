function tableFilter(t, predicate)
  local result = {}
  for key, value in pairs(t) do
    if predicate(value, key, t) then
      table.insert(result, value)
    end
  end
  return result
end

function tableMap(t, transform)
  local result = {}
  for key, value in pairs(t) do
    result[key] = transform(value, key, t)
  end
  return result
end


function tableFind(t, predicate)
  for key, value in pairs(t) do
    if predicate(value, key, t) then
      return value, key
    end
  end
  return nil
end

function tableFindString(t, searchString)
  for key, value in pairs(t) do
    if type(value) == "string" and string.find(value, searchString) then
      return value, key
    end
  end
  return nil
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mxsdev/nvim-dap-vscode-js",
		"Yonaba/Moses",
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" 
		},
		{
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
		{
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
        },
      },
    },
	},
	keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
	config = function() end,
	opts = function()
		require('dap-vscode-js').setup({
			debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug",
			adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
		})

		local dap = require('dap')

		local languages = {
			'javascript',
			'javascriptreact',
			'typescript',
			'typescriptreact'
		}

		local configs = {
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
				languages = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}
			},
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch (ESM/TS)",
				program = "${file}",
				cwd = "${workspaceFolder}",
				runtimeArgs = {
					"--loader",
					"ts-node/esm"
				},
				languages = { 'javascript', 'typescript' }
			},
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				languages = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
			}
		}

		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch (ESM)",
				program = "${file}",
				cwd = "${workspaceFolder}",
				runtimeArgs = {
					"--loader",
					"ts-node/esm"
				},
			},
		}




		for _, language in ipairs({ "javascript", "javascriptreact" }) do
			if not dap.configurations[language] then
				local languageConfigs = tableFilter(configs, function(config)
					return tableFindString(config.languages, language) ~= nil
				end)

				dap.configurations[language] = tableMap(languageConfigs, function(config)
					return config
				end)
			end
		end
	end
}
