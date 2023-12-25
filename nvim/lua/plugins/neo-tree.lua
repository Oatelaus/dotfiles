local options = {
	filesystem =  {
		filtered_items = {
			visible = true,
			show_hidden_count = true,
			hide_dotfiles = false,
			hide_gitignored = true,
		}
	},
	event_handlers = {
		{
				event = "file_opened",
				handler = function(file_path)
					require("neo-tree.command").execute({ action = "close" })
				end
			},
  }
}

return {
	"nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
	config = function()
		require("neo-tree").setup(options)
		vim.keymap.set("n", "<Leader>e", "<Cmd>Neotree reveal left toggle<CR>", { desc = "Toggle File Tree" })
		vim.keymap.set("n", "<Leader>tf", "<Cmd>Neotree reveal action=focus<CR>", { desc = "Focus File Tree" })
	end,
}
