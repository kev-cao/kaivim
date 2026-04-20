--- @module 'plugins.dev'
--- Testing and debugging plugins

local keymaps = require("kaivim.config.keymaps")

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
    },
    keys = keymaps.neotest.keys,
    opts = {
      adapters = {
        ["neotest-golang"] = {
          go_test_args = {"-v"},
          warn_test_name_dupes = false,
        },
        ["rustaceanvim.neotest"] = {},
      },
      discovery = {
        enabled = false,
      },
      output_panel = {
        open = "botright split | resize 12"
      },
    },
    config = function(_, opts)
      local adapters = {}
      for name, adapterOpts in pairs(opts.adapters) do
        table.insert(adapters, require(name)(adapterOpts))
      end
      opts.adapters = adapters
      require("neotest").setup(opts)
    end
  },
  {
    "igorlfs/nvim-dap-view",
    keys = keymaps.dap.keys,
    opts = {
      winbar = {
        sections = {
          "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console",
        },
        base_sections = {
          scopes = {
            keymap = "A",
            label = "Scopes",
          },
        },
        default_section = "scopes",
        controls = {
          enabled = true,
        }
      },
    },
    config = function(_, opts)
      local dap, dapview = require("dap"), require("dap-view")
      dapview.setup(opts)
      dap.listeners.before.attach.dapui_config = function()
        dapview.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapview.open()
      end
    end,
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      -- Also requires delve installed.
      "igorlfs/nvim-dap-view",
    },
    config = function()
      require("dap-go").setup()
    end,
    ft = "go",
    keys = keymaps.dapgo.keys,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "igorlfs/nvim-dap-view",
    },
    init = function()
      vim.o.switchbuf = "useopen,uselast"
    end,
    config = function()
      local dap = require("dap")
      local sys = require("kaivim.util.sys")
      dap.configurations.go = {
        {
          type = "go",
          request = "attach",
          name = "Attach to process",
          mode = "local",
          processId = require("dap.utils").pick_process,
          substitutePath = {
            {
              from = "/Users/kevin/go/src/github.com/cockroachdb/cockroach",
              to = "",
            },
          },
        },
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
          port = 2345,
          host = "127.0.0.1",
        },
      }

      dap.adapters.codelldb = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = sys.which("codelldb"),
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },
}
