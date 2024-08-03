return {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	config = function()
		-- Disable default bindings from Codeium.
		vim.g.codeium_disable_bindings = 1

		vim.keymap.set("i", "<C-g>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })
	end,
}
