return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
	},
	config = function()
		local function close_neo_tree()
			require("neo-tree.sources.manager").close_all()
			vim.notify("closed all")
		end

		local function open_neo_tree()
			vim.notify("opening neotree")
			require("neo-tree.sources.manager").show("filesystem")
		end

		local autosession = require("auto-session")

		autosession.setup({
			enabled = true,
			auto_save = true,
			auto_restore = true,
			auto_create = true,
			bypass_save_filetypes = { "neo-tree" },
			pre_save_cmds = {
				close_neo_tree,
			},
			post_restore_cmds = {
				open_neo_tree,
			},
		})
	end,
}
