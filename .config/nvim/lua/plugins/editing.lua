---@type LazySpec
return {
  "godlygeek/tabular",
  "kshenoy/vim-signature",
  "tomtom/tcomment_vim",
  "tpope/vim-unimpaired",
  "tpope/vim-vinegar",

  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = true,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
      vim.g.undotree_SplitWidth = 45
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_DiffCommand = "diff -dp -U 1"
    end,
  },

  {
    "lfv89/vim-interestingwords",
    branch = "master",
    init = function()
      -- These are jellybeans colors and some complements
      vim.g.interestingWordsGUIColors = {
        "#C4A258",
        "#6AADA0",
        "#71B9F8",
        "#A037B0",
        "#CF6A4C",
        "#D8AD4C",
      }
      vim.g.interestingWordsTermColors = {
        "179",
        "73",
        "75",
        "133",
        "167",
        "136",
      }
    end,
  },

  {
    "preservim/tagbar",
    cmd = "TagbarToggle",
    init = function()
      vim.g.tagbar_autoclose = 1
      vim.g.tagbar_autofocus = 1
      vim.g.tagbar_compact = 1
      vim.g.tagbar_width = 30
      if vim.fn.has("mac") == 1 then
        vim.g.tagbar_ctags_bin = "/opt/homebrew/bin/ctags"
      end
    end,
  },

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
