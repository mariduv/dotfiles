---@type LazySpec
return {
  -- mason is nonlazy so my executable tests work
  {
    "mason-org/mason.nvim",
    opts = {
      -- mason-lspconfig also has an ensure_installed but it is by lspconfig names,
      -- and tree-sitter isn't in that
      ensure_installed = {
        "tree-sitter-cli",
        "lua-language-server",
      }
    },
    config = function(_, opts)
      require("mason").setup({})

      local reg = require("mason-registry")
      for _, pkg in ipairs(opts.ensure_installed) do
        if not reg.is_installed(pkg) then
          reg.get_package(pkg):install()
        end
      end
    end
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    ---@module 'mason-lspconfig'
    ---@type MasonLspconfigSettings
    opts = {
      -- allow view / -R to also stop autostart. no other global flag for this.
      automatic_enable = not vim.list_contains(vim.v.argv, "-R"),
    }
  },
}
