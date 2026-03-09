local autocmd = require("config.util").autocmd

-- menus are defined in  which is defined in _defaults.lua or
-- runtime/lua/vim/_core/defaults.lua in neovim git.
-- the nvim.popupmenu augroup then hides some items on/off on the fly

-- Add K as the top item
vim.cmd.amenu("500.450", [[PopUp.Hover\ /\ Doc]], "K")

-- remove forever
vim.cmd.aunmenu("PopUp.Inspect")
vim.cmd.aunmenu([[PopUp.How-to\ disable\ mouse]])

-- and to the end
vim.cmd.amenu("500.550", [[PopUp.Git\ Blame]], ":TigBlame<CR>")

-- run after the default autocmd to keep some entries hidden
local g = vim.api.nvim_create_augroup("vimrc.popup", { clear = true })
autocmd(g, "MenuPopup", "*", function()
  -- this will error if default entries are ever dropped
  vim.cmd.amenu("disable", [[PopUp.Show\ All\ Diagnostics]])
  vim.cmd.amenu("disable", [[PopUp.Configure\ Diagnostics]])
  -- if i just removed them i'd need to disable the defaults fully
end)
