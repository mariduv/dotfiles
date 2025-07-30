local autocmd = require("config.util").autocmd
local g = vim.g

g.vimwiki_auto_chdir = 1
g.vimwiki_auto_header = 1
g.vimwiki_ext2syntax = { [vim.type_idx] = vim.types.dictionary }

g.vimwiki_list = {
  {
    path = "~/vimwiki/",
    auto_tags = 1,
    auto_toc = 1,
    automatic_nested_syntaxes = 1,
  },
  {
    path = "~/SynologyDrive/vimwiki",
    auto_tags = 1,
    auto_toc = 1,
    automatic_nested_syntaxes = 1,
  },
}


-- date header auto added by vimwiki.
-- auto-copy tomorrow from yesterday would be fun.
-- luaLS formatting removes trailing ws on those bullets and this annotation
-- doesn't seem to work anymore

---@format disable-next
local diary_snippet = [=[

== Tasks ==

- [ ] 

Quick Tasks:
- [ ] 

Tomorrow:


== Schedule ==


== Notes ==


]=]

autocmd(
  vim.api.nvim_create_augroup("vimrc_vimwiki", { clear = true }),
  "BufNewFile", "*wiki/diary/*.wiki",
  function() vim.snippet.expand(diary_snippet) end
)


---@type LazySpec
return {
  {
    "vimwiki/vimwiki",
    keys = {
      { "<leader>ww",         "<Plug>VimwikiIndex" },
      { "<leader>w<leader>w", "<Plug>VimwikiMakeDiaryNote" },
    },
    ft = { "vimwiki", "vimwiki_markdown_custom" },
  },
}
