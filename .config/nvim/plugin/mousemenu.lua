-- menus are defined in defaults which is defined in _defaults.lua or
-- runtime/lua/vim/_core/defaults.lua in neovim git.
-- the nvim.popupmenu augroup then hides some items on/off on the fly

-- clear default popup
vim.cmd([[aunmenu PopUp]])
vim.api.nvim_del_augroup_by_name("nvim.popupmenu")

-- and rewrite our own
vim.cmd([[
  amenu     PopUp.Open\ in\ web\ browser  gx
  amenu     PopUp.Hover\ /\ Doc           K
  anoremenu PopUp.Show\ Diagnostics       <Cmd>lua vim.diagnostic.open_float()<CR>
  anoremenu PopUp.Go\ to\ definition      <Cmd>lua vim.lsp.buf.definition()<CR>
  anoremenu PopUp.Go\ to\ type            <Cmd>lua vim.lsp.buf.type_definition()<CR>
  anoremenu PopUp.-1-                     <Nop>
  vnoremenu PopUp.Cut                     "+x
  vnoremenu PopUp.Copy                    "+y
  anoremenu PopUp.Paste                   "+gP
  vnoremenu PopUp.Paste                   "+P
  vnoremenu PopUp.Delete                  "_x
  nnoremenu PopUp.Select\ All             ggVG
  vnoremenu PopUp.Select\ All             gg0oG$
  inoremenu PopUp.Select\ All             <C-Home><C-O>VG
  anoremenu PopUp.-2-                     <Nop>
  nnoremenu PopUp.Git\ Blame              <Cmd>TigBlame<CR>
]])

local function enable_ctx_menu()
  vim.cmd([[
    amenu disable PopUp.Open\ in\ web\ browser
    amenu disable PopUp.Show\ Diagnostics
    amenu disable PopUp.Go\ to\ definition
    amenu disable PopUp.Go\ to\ type
    nmenu disable PopUp.Git\ Blame
  ]])

  local url = require('vim.ui')._get_urls()[1]
  if url and vim.startswith(url, 'http') then
    vim.cmd([[amenu enable PopUp.Open\ in\ web\ browser]])
  elseif vim.lsp.get_clients({ bufnr = 0 })[1] then
    vim.cmd([[anoremenu enable PopUp.Go\ to\ definition]])
    vim.cmd([[anoremenu enable PopUp.Go\ to\ type]])
  end

  local lnum = vim.fn.getcurpos()[2] - 1 ---@type integer
  if next(vim.diagnostic.get(0, { lnum = lnum })) ~= nil then
    vim.cmd([[anoremenu enable PopUp.Show\ Diagnostics]])
  end

  if require("snacks").git.get_root() then
    vim.cmd([[nnoremenu enable PopUp.Git\ Blame]])
  end
end

local nvim_popupmenu_augroup = vim.api.nvim_create_augroup('vimrc.popupmenu', {clear = true})
vim.api.nvim_create_autocmd('MenuPopup', {
  pattern = '*',
  group = nvim_popupmenu_augroup,
  desc = 'Mouse popup menu (dynamic entries)',
  callback = function()
    enable_ctx_menu()
  end,
})
