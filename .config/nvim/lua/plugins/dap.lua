---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      { "theHamsta/nvim-dap-virtual-text", config = true },

      { "suketa/nvim-dap-ruby",            config = true },
      "leoluz/nvim-dap-go",
      {
        "mfussenegger/nvim-dap-python",
        ft = { "python" },
        config = function() require("dap-python").setup("debugpy-adapter") end
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<Leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Message: ")) end,    desc = "Log Point" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>da", function() require("dap").continue({ before = vim.fn.input("Args: ") }) end,          desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dL", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>dO", function() require("dap").step_out() end,                                             desc = "Step Out" }, -- switched o/O from lazyvim
      { "<leader>do", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() vim.print(require("dap").session()) end,                                   desc = "Session" },
      { "<leader>dD", function() require("dap").disconnect() end,                                           desc = "Disconnect" },
      { "<leader>dT", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },
    cmd = { "DapContinue", "DapNew" },
    config = function()
      local dap = require("dap")

      -- configs also made by nvim-dap-{go,python,ruby} deps above

      dap.adapters.codelldb = {
        type = "executable",
        command = "codelldb",
      }

      dap.configurations.zig = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    branch = "master",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
    },
    opts = {
      controls = {
        icons = {
          disconnect = "[d]",
          pause = "[p]",
          play = "[c]",
          run_last = "[l]",
          step_back = "[u]",
          step_into = "[i]",
          step_out = "[O]",
          step_over = "[o]",
          terminate = "[t]",
        }
      }
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open({})
      end
    end,
  },

  {
    "leoluz/nvim-dap-go",
    config = function()
      local dap = require("dap")
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach port",
            mode = "remote",
            request = "attach",
            host = "localhost",
            port = function()
              local port = vim.fn.input("Target port: ", "4000")
              return (port and port ~= "") and port or dap.ABORT
            end
          },
        }
      })

      -- bug workaround: wrap adapter config func to not include "executable" key if remoting
      ---@diagnostic disable:undefined-field
      local dap_go_orig = dap.adapters.go
      dap.adapters.go = function(callback, client_config)
        if client_config.mode == "remote" then
          callback({
            type = "server",
            host = client_config.host or "127.0.0.1",
            port = client_config.port or "4000",
          })
          return
        end
        dap_go_orig(callback, client_config)
      end
    end
  },
}
