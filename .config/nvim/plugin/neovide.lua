if not vim.g.neovide then
  return
end

-- this is a workaround because just setting it on lsp_attach doesn't seem to
-- stick on neovide's side.
vim.go.mousemoveevent = true

vim.g.neovide_show_border = true
vim.g.neovide_padding_top = 2
vim.g.neovide_padding_bottom = 4
vim.g.neovide_padding_left = 4
vim.g.neovide_padding_right = 4

vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00

vim.g.neovide_scale_factor = 1.0

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

if vim.fn.has('mac') == 1 then
  vim.o.guifont = "DejaVu Sans Mono:h12"

  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  vim.keymap.set("n", "<D-=>", function() change_scale_factor(1.10) end)
  vim.keymap.set("n", "<D-->", function() change_scale_factor(1 / 1.10) end)

  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y')    -- Copy
  vim.keymap.set('n', '<D-v>', '"+P')    -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P')    -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<C-R>+') -- Paste insert mode
else
  vim.o.guifont = "DejaVu Sans Mono:h10"

  vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.10) end)
  vim.keymap.set("n", "<C-->", function() change_scale_factor(1 / 1.10) end)
end

