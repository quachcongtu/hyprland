return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "sindrets/diffview.nvim" },
        opts = {
            signcolumn = true,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Làm dấu thay đổi (~) đậm hơn
                vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e0af68", bold = true })

                -- tiện tạo keymap
                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                end

                -- 🔹 Điều hướng hunk
                map("n", "]h", gs.next_hunk, "Next hunk")    -- sang hunk tiếp theo
                map("n", "[h", gs.prev_hunk, "Prev hunk")    -- về hunk trước đó

                -- 🔹 Stage / Reset
                map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")   -- add hunk vào git
                map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")   -- bỏ thay đổi hunk
                map("v", "<leader>hs", function()                     -- stage vùng chọn
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Stage hunk (visual)")
                map("v", "<leader>hr", function()                     -- reset vùng chọn
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Reset hunk (visual)")

                -- 🔹 Toàn buffer
                map("n", "<leader>hS", gs.stage_buffer, "Stage buffer") -- add toàn file
                map("n", "<leader>hR", gs.reset_buffer, "Reset buffer") -- bỏ thay đổi toàn file

                -- 🔹 Blame
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = true })     -- blame chi tiết 1 dòng
                end, "Blame line (full)")
                map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame") -- bật/tắt blame inline

                -- 🔹 Diff
                map("n", "<leader>hd", gs.diffthis, "Diff this")        -- diff với HEAD
                map("n", "<leader>hD", function()
                    gs.diffthis("~")                                   -- diff với commit trước
                end, "Diff this ~")

                -- 🔹 Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")

                -- 🔹 Diffview toggle
                vim.keymap.set("n", "<leader>dv", function()
                    if next(require("diffview.lib").views) == nil then
                        vim.cmd("DiffviewOpen")     -- mở diffview
                    else
                        vim.cmd("DiffviewClose")    -- đóng diffview
                    end
                end, { desc = "Toggle Diffview" })
            end,
        },
    },
}

