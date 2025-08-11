local g = vim.g

g.neo_tree_remove_legacy_commands = 1

---@type LazySpec
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode", "selectioncount" },
        lualine_b = { "filename", "searchcount" },
        lualine_c = { "diagnostics", "diff" },
        lualine_x = { "encoding", "fileformat" },
        lualine_y = { "filetype" },
        lualine_z = { "progress", "location" },
      },
      inactive_sections = {
        lualine_c = { { "filename", path = 1 }, "searchcount" },
        lualine_x = { "filetype", "location" },
      },
      tabline = {
        lualine_a = {
          { "buffers", mode = 4, show_filename_only = false, use_mode_colors = true },
        },
        lualine_y = { "lsp_status" },
        lualine_z = { "branch" },
      },
      extensions = {
        "quickfix", "neo-tree", "nvim-dap-ui",
        -- local
        "tagbar"
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    keys = {
      { "<leader>ig", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Guides" },
    },
    opts = {
      enabled = false,
      indent = { char = "│" },
      whitespace = { remove_blankline_trail = true },
      scope = { enabled = false },
    },
  },

  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        animation = function()
          return 2
        end,
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        config = function(_, _)
          local theme = require("kanagawa.colors").setup().theme
          require("window-picker").setup({
            use_winbar = "always",
            fg_color = theme.ui.fg_reverse,
            current_win_hl_color = theme.syn.constant,
            other_win_hl_color = theme.syn.fun,
          })
        end,
      },
    },
    opts = {
      enable_git_status = false,
      window = { mappings = { ["<F2>"] = "close_window" } },
      filesystem = { hijack_netrw_behavior = "disabled" },
      default_component_configs = {
        icon = {
          folder_closed = "▷",
          folder_open = "▽",
          folder_empty = "¤",
          default = "•",
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
      delay = 500,
      filter = function(m) return m.desc ~= "" end,
      icons = { rules = false },
      replace = { key = {} },
    },
  },
}
