return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local function short_filename()
            local root = vim.fn.getcwd()
            local filepath = vim.fn.expand("%:p")
            if not filepath:find(root, 1, true) then
                return vim.fn.expand("%:t")
            end

            local relpath = filepath:sub(#root + 2)
            local parts = vim.split(relpath, "/")
            local len = #parts
            if len > 2 then
                return table.concat({ parts[len - 2], parts[len - 1], parts[len] }, "/")
            else
                return relpath
            end
        end
        require("lualine").setup({
            options = {
                theme = "OceanicNext",
            },
            sections = {
                lualine_c = {
                    { short_filename },
                },
                lualine_z = {},
            },
        })
    end,
}

-- return {
--   {
--     "nvim-lualine/lualine.nvim",
--     opts = function()
--       return {
--         options = {
--           theme = "auto",
--           globalstatus = true,
--           section_separators = { left = "", right = "" }, -- tam giác nhọn
--           component_separators = { left = "", right = "" }, -- gạch nhọn
--         },
--         sections = {
--           lualine_a = { "mode" },
--           lualine_b = { "branch" },
--           lualine_c = {
--             { "diagnostics" },
--             { "filename", path = 1 }, -- hiển thị tên file + path
--           },
--           lualine_x = {
--             { "diff" },
--             { "encoding" },
--             { "filetype" },
--           },
--           lualine_y = { "progress" },
--           lualine_z = {
--             { "location" },
--             {
--               function()
--                 return os.date("%H:%M")
--               end,
--               icon = "",
--             },
--           },
--         },
--       }
--     end,
--   },
-- }
--
