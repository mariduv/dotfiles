vim.lsp.set_log_level("OFF")

vim.diagnostic.config({
  float = {
    border = "rounded",
    anchor_bias = "below",
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    focusable = false,
    header = "",
    max_width = 72,
    source = "if_many",
  },
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_opts", { clear = true }),
  callback = function(args)
    vim.opt.number = true
    vim.opt.updatetime = 250

    vim.api.nvim_create_autocmd("CursorHold", {
      group = vim.api.nvim_create_augroup("lsp_buf_diags_" .. args.buf, { clear = true }),
      buffer = args.buf,
      callback = function(e)
        local existing_float = vim.b[e.buf].lsp_floating_preview
        if existing_float and vim.api.nvim_win_is_valid(existing_float) then
          return
        end
        vim.diagnostic.open_float()
      end,
    })
  end,
})
