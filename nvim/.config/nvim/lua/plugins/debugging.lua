return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- UI for debugging
			"rcarriga/nvim-dap-ui",

			-- Dependency for nvim-dap-ui
			"nvim-neotest/nvim-nio",

			-- Installs debug adapters
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Custom debugger installs
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					"delve",
				},
			})

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			dapui.setup({
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue execution" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })
			vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result" })
		end,
	},
}
