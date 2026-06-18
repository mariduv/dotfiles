---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      default_format_opts = {
        lsp_format = "prefer",
      },
      formatters_by_ft = {
        dockerfile = { "dockerfmt" },
        elixir = { "mix" },
        go = { "goimports", "gofumpt" },
        lua = { "stylua" },
        mail = { "pandoc_markdown", "injected" },
        markdown = { "pandoc_markdown", "injected" },
        perl = { "perltidy" },
        ruby = { "standardrb", "rubocop", stop_after_first = true },
        sh = { "shfmt" },
        sql = { "pg_format" },
      },
      formatters = {
        pandoc_markdown = {
          command = "pandoc",
          args = { "-f", "markdown", "-t", "markdown", "--wrap=preserve"},
          stdin = true,
        },
        shfmt = {
          prepend_args = function(_, ctx)
            return { "-i", vim.bo[ctx.buf].shiftwidth }
          end,
        },
        perltidy = {
          prepend_args = function(_, ctx)
            return { "-i", vim.bo[ctx.buf].shiftwidth }
          end,
        },
      },
      format_on_save = function(bufnr)
        local autoformat_filetypes = { "elixir", "go" }

        if not vim.tbl_contains(autoformat_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        return {
          timeout_ms = 1000,
        }
      end
    },
  },
}
