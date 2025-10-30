return {
    "HiPhish/rainbow-delimiters.nvim",

    config = function()
        local rainbow_delimiters = require("rainbow-delimiters")

        -- Lấy bảng màu từ theme tokyonight
        local colors = require("tokyonight.colors").setup()

        -- Gán lại highlight group
        vim.api.nvim_set_hl(0, "RainbowDelimiterRed",    { fg = colors.red })
        vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "RainbowDelimiterBlue",   { fg = colors.blue })
        vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = colors.orange })
        vim.api.nvim_set_hl(0, "RainbowDelimiterGreen",  { fg = colors.green })
        vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = colors.purple })
        vim.api.nvim_set_hl(0, "RainbowDelimiterCyan",   { fg = colors.cyan })

        -- Cấu hình rainbow-delimiters
        vim.g.rainbow_delimiters = {
            strategy = {
                [""]  = rainbow_delimiters.strategy["global"],
                vim   = rainbow_delimiters.strategy["local"],
            },
            query = {
                [""]  = "rainbow-delimiters",
                lua   = "rainbow-blocks",
            },
            highlight = {
                "RainbowDelimiterRed",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
            },
        }
    end,
}

