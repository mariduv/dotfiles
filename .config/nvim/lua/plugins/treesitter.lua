---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    opts = {
      highlight = {
        enable = true,
        disable = { "perl" },
      },
      indent = { enable = true },
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
      parser_install_dir = vim.fn.stdpath("data") .. "/site",
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      vim.api.nvim_set_hl(0, "@keyword.pod", { link = "MoreMsg" })
      vim.api.nvim_set_hl(0, "@markup.raw.pod", { link = "PreProc" })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true }),
        callback = function(args)
          local filetype = args.match
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not vim.treesitter.language.add(language) then
            return
          end

          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
      })
    end,
  },
}
