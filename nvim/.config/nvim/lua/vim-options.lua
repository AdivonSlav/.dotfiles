vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.nu = true
vim.opt.smartindent = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.autoindent = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.background = "dark"
vim.opt.splitright = true
vim.opt.autoread = true
vim.opt.swapfile = false

vim.g.omni_sql_no_default_maps = 1

-- Use the system clipboard.
--vim.cmd("set clipboard+=unnamedplus")

-- Leader key setup.
vim.g.mapleader = " "

-- Keymaps.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "General: Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "General: Move line up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "General: Navigate half page down" })
vim.keymap.set("n", "C-u>", "<C-u>zz", { desc = "General: Navigate half page up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "General: Go to next search item centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "General: Go to previous search item centered" })

vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "General: Yank to system clipboard " })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "General: Paste from system clipboard" })

vim.keymap.set("n", "Q", "<nop>", { desc = "General: just to prevent bad things from happening", silent = true })

vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "General: Search and replace under cursor" }
)

vim.keymap.set(
    { "i", "n", "v" },
    "<C-C>",
    "<esc>",
    { desc = "General: Make Ctrl+C behave exactly like escape", silent = true }
)

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "General: Clear search highlights" })

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Window: Split vertically" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Window: Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Window: Close current split" })
-- vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Window: Move to left split" })
-- vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Window: Move to right split" })

vim.keymap.set("n", "x", '"_x', { desc = "General: Delete character without copying ", silent = true })
vim.keymap.set("v", "p", '"_dP', { desc = "General: Keep last yanked when pasting", silent = true })
vim.keymap.set("n", "dd", '"_dd', { desc = "General: Delete line without copying ", silent = true })
