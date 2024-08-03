return {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {},
    config = function()
        local scrollEOF = require("scrollEOF")
        scrollEOF.setup()
    end,
}
