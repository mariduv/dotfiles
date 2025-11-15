---@type LazySpec
return {
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
  { "yko/mojo.vim", branch = "master" },

  {
    "vim-perl/vim-perl",
    branch = "dev",
    init = function()
      vim.g.perl_include_pod = 1
      vim.g.perl_sub_signatures = 1
      vim.g.perl_sync_dist = 300
      vim.g.perl_compiler_force_warnings = 0
    end,
  },

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
