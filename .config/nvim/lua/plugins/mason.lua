---@type LazySpec
return {
  -- mason is nonlazy so my executable tests work
  {
    "mason-org/mason.nvim",
    config = function(_, _)
      require("mason").setup({})

      local reg = require("mason-registry")

      if not reg.is_installed("tree-sitter-cli") then
        reg.get_package("tree-sitter-cli"):install()
      end
    end
  },
}

