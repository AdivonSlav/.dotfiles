return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>xw",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Trouble: Diagnostics",
		},
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
			desc = "Trouble: Buffer Diagnostics",
		},
	},
}
