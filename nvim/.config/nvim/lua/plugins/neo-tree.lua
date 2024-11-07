return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "2rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	cmd = "Neotree",
	config = function()
		local neotree = require("neo-tree")

		neotree.setup({
			close_if_last_window = true,
			auto_clean_after_session_restore = true,
			default_component_configs = {
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "◻",
				},

				git_status = {
					symbols = {
						modified = "",
						unstaged = "",
					},
				},
			},
			filesystem = {
				follow_current_file = true,
			},
		})

		vim.keymap.set(
			"n",
			"<C-n>",
			":Neotree filesystem reveal left toggle<CR>",
			{ desc = "Neotree: Toggle filesystem left", silent = true }
		)
	end,
}
