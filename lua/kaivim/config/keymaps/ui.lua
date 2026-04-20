local M = {}

M.whichkey = {
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      mode = "n",
      desc = "Show keymaps",
    },
    {
      "<C-_>",
      function()
        require("which-key").show({ global = true })
      end,
      mode = "i",
      desc = "Show keymaps",
    },
  },
}

M.neoscroll = {
  keys = {
    {
      "<C-y>",
      function()
        require("neoscroll").scroll(-1, {
          move_cursor = false,
          easing = nil,
          duration = 0,
        })
      end,
      mode = { "n", "v", "x" },
      desc = "Scroll up 1 line",
    },
    {
      "<C-e>",
      function()
        require("neoscroll").scroll(1, {
          move_cursor = false,
          easing = nil,
          duration = 0,
        })
      end,
      mode = { "n", "v", "x" },
      desc = "Scroll down 1 line",
    },
  },
}

M.noice = {
  keys = {
    {
      "<leader><BS>",
      "<cmd>Noice dismiss<CR>",
      mode = "n",
      desc = "Dismiss messages",
    }
  }
}

return M
