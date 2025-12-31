---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      -- tree-sitter-cli via mason.nvim
      "mason-org/mason.nvim",
      "RRethy/nvim-treesitter-endwise",
    },
    opts = {
      highlight = { disable = { "perl" } },
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
    },
    config = function(_, opts)
      if not vim.fn.executable("tree-sitter") then
        vim.defer_fn(function ()
          vim.notify("tree-sitter cli not available", vim.log.levels.WARN)
        end, 1500)
        return
      end

      require("nvim-treesitter").install(opts.ensure_installed)

      vim.api.nvim_set_hl(0, "@keyword.pod", { link = "MoreMsg" })
      vim.api.nvim_set_hl(0, "@markup.raw.pod", { link = "PreProc" })

      local function activate(buf, language)
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        if not vim.tbl_contains(opts.highlight.disable, language) then
          vim.treesitter.start(buf, language)
        end
      end

      local function try_install(buf, language)
        require("nvim-treesitter").install({language}):await(function()
          if vim.treesitter.language.add(language) then
            activate(buf, language)
          end
        end)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true }),
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not vim.treesitter.language.add(language) then
            try_install(buf, language)
            return
          end

          activate(buf, language)
        end,
      })
    end,
  },
}
