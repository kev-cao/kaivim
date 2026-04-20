local M = {}

M.copilot = {
  keys = {
    {
      "<C-l>",
      function()
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
          copilot.accept()
        end
      end,
      mode = "i",
      desc = "Accept Copilot suggestion",
    },
    {
      "<C-h>",
      function()
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
          copilot.accept_line()
        end
      end,
      mode = "i",
      desc = "Accept Copilot suggestion line",
    },
    {
      "<C-n>",
      function()
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
          copilot.next()
        end
      end,
      mode = "i",
      desc = "Next Copilot suggestion",
    },
    {
      "<C-p>",
      function()
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
          copilot.prev()
        end
      end,
      mode = "i",
      desc = "Previous Copilot suggestion",
    },
  },
}

M.claude = {
  keys = {
    {
      "<leader>cc",
      "<cmd>ClaudeCode<CR>",
      mode = "n",
      desc = "Toggle Claude Code",
    },
    {
      "<leader>cr",
      "<cmd>ClaudeCodeResume<CR>",
      mode = "n",
      desc = "Resume Claude Session",
    }
  }
}

M.opencode = {
  keys = {
    {
      "<leader>cc",
      function()
        require("opencode").toggle()
      end,
      mode = "n",
      desc = "Toggle OpenCode",
    },
  }
}

return M
