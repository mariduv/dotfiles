local g = vim.g

-- >> Perl
g.perl_include_pod = 1
g.perl_sub_signatures = 1
g.perl_sync_dist = 300
g.perl_compiler_force_warnings = 0

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    event = "VeryLazy",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          disable = { "perl" },
        },
        indent = { enable = true },
        endwise = { enable = true },
        auto_install = true,
        ensure_installed = {
          "c",
          "comment",
          "diff",
          "eex",
          "elixir",
          "go",
          "heex",
          "lua",
          "perl",
          "pod",
          "python",
          "regex",
          "ruby",
          "surface",
          "sql",
          "vim",
          "vimdoc",
        },
      })
      vim.api.nvim_set_hl(0, "@keyword.pod", { link = "MoreMsg" })
      vim.api.nvim_set_hl(0, "@markup.raw.pod", { link = "PreProc" })
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  { "Shougo/vinarise.vim", cmd = "Vinarise" },
  "asciidoc/vim-asciidoc",
  { "vim-perl/vim-perl", branch = "dev" },
  { "yko/mojo.vim", branch = "master" },

  -- Because of Elixir/OTP mismatches, this is more reliable than Mason for
  -- elixir-ls
  {
    "elixir-tools/elixir-tools.nvim",
    ft = { "elixir", "eelixir", "heex" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = false,
            enableTestLenses = false,
          }),
          on_attach = function(_, _)
            vim.keymap.set("n", "<leader>fp", ":ElixirFromPipe<cr>", { buffer = true })
            vim.keymap.set("n", "<leader>tp", ":ElixirToPipe<cr>", { buffer = true })
            vim.keymap.set("v", "<leader>em", ":ElixirExpandMacro<cr>", { buffer = true })
          end,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
