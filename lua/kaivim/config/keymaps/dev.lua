local keymaps = require("kaivim.util.keymaps")

local M = {}

M.neotest = {
  keys = {
    {
      "<leader><S-t>s",
      function()
        require("neotest").run.run({ suite = true })
        keymaps.toggle_neotest_ui({ open = true })
      end,
      mode = "n",
      desc = "Run test suite",
    },
    {
      "<leader><S-t>f",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
        keymaps.toggle_neotest_ui({ open = true, clear = true })
      end,
      mode = "n",
      desc = "Run test file",
    },
    {
      "<leader><S-t>t",
      function()
        require("neotest").run.run()
        keymaps.toggle_neotest_ui({ open = true, clear = true })
      end,
      mode = "n",
      desc = "Run nearest test",
    },
    {
      "<leader><S-t>d",
      function()
        require("neotest").run.run({ strategy = "dap" })
        require("neotest").summary.open()
      end,
      mode = "n",
      desc = "Debug nearest test",
    },
    {
      "<leader><S-t>l",
      function()
        require("neotest").run.run_last()
        keymaps.toggle_neotest_ui({ open = true, clear = true })
      end,
      mode = "n",
      desc = "Run last test",
    },
    {
      "<leader><S-t>o",
      function()
        keymaps.toggle_neotest_ui()
      end,
      mode = "n",
      desc = "Toggle test output",
    },
  },
  ["output-panel"] = {
    {
      "q",
      function()
        keymaps.toggle_neotest_ui({ close = true })
      end,
      mode = { "n", "t" },
      desc = "Close test output panel",
    },
    {
      "<localleader>c",
      function()
        require("neotest").output_panel.clear()
      end,
      mode = { "n", "t" },
      desc = "Clear test output panel",
    },
  }
}

M.dap = {
  keys = {
    {
      "<leader>db",
      "<cmd>DapToggleBreakpoint<CR>",
      mode = "n",
      desc = "Toggle breakpoint",
    },
    {
      "<leader>dfb",
      '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
      mode = "n",
      desc = "Set conditional breakpoint",
    },
    {
      "<leader>dlb",
      '<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
      mode = "n",
      desc = "Set log breakpoint",
    },
    {
      "<leader>dc",
      "<cmd>DapContinue<CR>",
      mode = "n",
      desc = "[Debugger] Continue",
    },
    {
      "<leader>ds",
      "<cmd>DapStepOver<CR>",
      mode = "n",
      desc = "[Debugger] Step over",
    },
    {
      "<leader>di",
      "<cmd>DapStepInto<CR>",
      mode = "n",
      desc = "[Debugger] Step into",
    },
    {
      "<leader>do",
      "<cmd>DapStepOut<CR>",
      mode = "n",
      desc = "[Debugger] Step out",
    },
    {
      "<leader>dd",
      "<cmd>DapDisconnect<CR>",
      mode = "n",
      desc = "[Debugger] Disconnect",
    },
    {
      "<leader>dx",
      "<cmd>DapTerminate<CR>",
      mode = "n",
      desc = "[Debugger] Terminate",
    },
    -- Since I'm always going to be using dap-view with dap, I'm going to include
    -- dap-view keymaps in the dap keymaps.
    {
      "<leader>du",
      "<cmd>DapViewToggle<CR>",
      mode = "n",
      desc = "Toggle dap-ui",
    },
    {
      "<leader>dw",
      "<cmd>DapViewWatch<CR>",
      mode = "n",
      desc = "Evaluate expression",
    },
  },
}

M.dapgo = {
  keys = {
    {
      "<leader>dtt",
      '<cmd>lua require("dap-go").debug_test()<CR>',
      mode = "n",
      desc = "Debug nearest test",
    },
    {
      "<leader>dtl",
      '<cmd>lua require("dap-go").debug_last_test()<CR>',
      mode = "n",
      desc = "Debug last test",
    },
  },
}

return M
