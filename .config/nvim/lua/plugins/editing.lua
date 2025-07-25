local g = vim.g

-- >> Undotree
g.undotree_SplitWidth = 45
g.undotree_SetFocusWhenToggle = 1
g.undotree_ShortIndicators = 1
g.undotree_DiffCommand = "diff -dp -U 1"

-- >> Tagbar
g.tagbar_autoclose = 1
g.tagbar_autofocus = 1
g.tagbar_compact = 1
g.tagbar_width = 30

-- >> interestingwords
-- These are jellybeans colors and some complements
g.interestingWordsGUIColors = {
  "#C4A258",
  "#6AADA0",
  "#71B9F8",
  "#A037B0",
  "#CF6A4C",
  "#D8AD4C",
}
g.interestingWordsTermColors = {
  "179",
  "73",
  "75",
  "133",
  "167",
  "136",
}

---@type LazySpec
return {
  "tpope/vim-unimpaired",
  "tomtom/tcomment_vim",

  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = true
  },

  -- "tpope/vim-endwise",
  -- treesitter-endwise only applies if the parser is installed. do i want to
  -- worry about a fallback?

  "godlygeek/tabular",
  { "mbbill/undotree", cmd = "UndotreeToggle" },

  "tpope/vim-vinegar",
  { "lfv89/vim-interestingwords", branch = "master" },
  "kshenoy/vim-signature",
  { "majutsushi/tagbar", cmd = "TagbarToggle" },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 250,
      large_file_cutoff = 15000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
