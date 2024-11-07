return {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
    },
    config = function()
        -- So auto-session behaves.
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

        local autosession = require("auto-session")

        autosession.setup({
            enabled = true,
            auto_save = true,
            auto_restore = true,
            auto_create = true,
            bypass_save_filetypes = { "neo-tree" },
            pre_save_cmds = {
                "Neotree close",
            },
            post_restore_cmds = {
                "Neotree filesystem show",
            },
        })
    end,
}
