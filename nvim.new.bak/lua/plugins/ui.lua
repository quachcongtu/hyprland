return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = { left = "", right = "" }, -- tam giác nhọn
          component_separators = { left = "", right = "" }, -- gạch nhọn
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            { "diagnostics" },
            { "filename", path = 1 }, -- hiển thị tên file + path
          },
          lualine_x = {
            { "diff" },
            { "encoding" },
            { "filetype" },
          },
          lualine_y = { "progress" },
          lualine_z = {
            { "location" },
            {
              function()
                return os.date("%H:%M")
              end,
              icon = "",
            },
          },
        },
      }
    end,
  },
}

