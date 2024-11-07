return {
	"mrjones2014/smart-splits.nvim",
	build = "./kitty/install-kittens.bash",
	opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
	config = function()
		vim.keymap.set("n", "<A-h>", function()
			require("smart-splits").move_cursor_left()
		end, { silent = true })
		vim.keymap.set("n", "<A-j>", function()
			require("smart-splits").move_cursor_down()
		end, { silent = true })
		vim.keymap.set("n", "<A-k>", function()
			require("smart-splits").move_cursor_up()
		end, { silent = true })
		vim.keymap.set("n", "<A-l>", function()
			require("smart-splits").move_cursor_right()
		end, { silent = true })

		vim.keymap.set("n", "<C-A-h>", function()
			require("smart-splits").resize_left()
		end, { silent = true })
		vim.keymap.set("n", "<C-A-j>", function()
			require("smart-splits").resize_down()
		end, { silent = true })
		vim.keymap.set("n", "<C-A-k>", function()
			require("smart-splits").resize_up()
		end, { silent = true })
		vim.keymap.set("n", "<C-A-l>", function()
			require("smart-splits").resize_right()
		end, { silent = true })
	end,
}
