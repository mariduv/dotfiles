---@type LazySpec
return {
  -- mason is nonlazy so my executable tests work
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        "lua-language-server",
      }
    },
    config = function(_, opts)
      local reg = require("mason-registry")

      require("mason").setup({})

      for _, pkg in ipairs(opts.ensure_installed) do
        if not reg.is_installed(pkg) then
          reg.get_package(pkg):install()
        end
      end

    end
  },
}

