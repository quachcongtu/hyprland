-- pull lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins and options
require("vim-options")
require("vim-helpers")
require("help-floating")
require("floating-term")
-- require("lazy").setup("plugins")
local uname = vim.loop.os_uname()
local hostname = vim.loop.os_gethostname()
lazy_opts = {}
if not (uname.sysname == "Darwin" and hostname == "meomeo") then
    lazy_opts.lockfile = "~/nix/dotfiles/nvim/lazy-lock.json"
end
require("lazy").setup("plugins", lazy_opts)
require("snipets")
vim.diagnostic.config({
  virtual_text = false,
})
vim.o.wrap = false

-- cho ~ có màu giống số dòng và đậm
vim.api.nvim_set_hl(0, "EndOfBuffer", { link = "LineNr" })
vim.api.nvim_set_hl(0, "LineNr", { bold = true })
vim.keymap.set("n", "<leader>nb", ":set relativenumber!<CR>", { desc = "Toggle relativenumber", silent = true })

