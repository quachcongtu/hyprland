return {
    "akinsho/toggleterm.nvim",

    config = function()
        require("toggleterm").setup({
            start_in_insert = true,
            shade_terminals = false, -- không làm tối terminal
        })

        -- Làm terminal trong suốt toàn bộ
        vim.cmd([[
            hi Normal guibg=NONE ctermbg=NONE
            hi NormalNC guibg=NONE ctermbg=NONE
            hi NormalFloat guibg=NONE ctermbg=NONE
            hi FloatBorder guibg=NONE ctermbg=NONE
            hi SignColumn guibg=NONE ctermbg=NONE
            hi VertSplit guibg=NONE ctermbg=NONE
            hi EndOfBuffer guibg=NONE ctermbg=NONE
        ]])

        -- Mở terminal ngang dưới màn hình với leader + `
        vim.keymap.set("n", "<leader>`", ":ToggleTerm size=10 direction=horizontal<CR>", 
            { desc = "Open Bottom Terminal", silent = true })

        -- Thoát terminal mode bằng Esc
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], {})
    end
}

