---@diagnostic disable: lowercase-global
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local config = require("catppuccin")
		config.setup({
			flavour = "auto",
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			term_colors = true,
			integrations = {
				neotree = true,
				treesitter = true,
				telescope = {
					enabled = true,
				},
				cmp = true,
				alpha = true,
				mason = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
