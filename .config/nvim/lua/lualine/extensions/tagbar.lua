vim.g.tagbar_no_status_line = true

local M = {}

M.filetypes = { "tagbar" }

M.fn = {}

function M.fn.current_file()
  return vim.fn["tagbar#state#get_current_file"](0)
end

function M.fn.sort_order()
  local fileinfo = M.fn.current_file()
  local sorted = (fileinfo and fileinfo.typeinfo.sort == 1) or vim.g.tagbar_sort == 1
  return sorted and "▼ Name" or ""
end

function M.fn.flags()
  return "[" ..
    (vim.w.autoclose == 1 and "c" or "") ..
    (vim.g.tagbar_autoclose == 1 and "C" or "") ..
    (M.fn.sort_order() ~= "" and vim.g.tagbar_case_insensitive == 1 and "i" or "") ..
    (vim.g.tagbar_hide_nonpublic == 1 and "v" or "") ..
    "]"
end

function M.fn.current_file_name()
  local fileinfo = M.fn.current_file()
  if fileinfo then
    return vim.fn.fnamemodify(fileinfo.fpath, ":t")
  end
  return ""
end

M.sections = {
  lualine_a = { M.fn.flags },
  lualine_b = { M.fn.current_file_name },
  lualine_y = { M.fn.sort_order },
}

return M
