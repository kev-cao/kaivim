local M = {}

M.floaterm = {
  keys = {
    {
      "<leader>t",
      "<cmd>FloatermToggle<CR>",
      mode = {"n", "t"},
      desc = "Toggle terminal",
    },
    {
      "<leader>n",
      "<cmd>FloatermNew<CR>",
      mode = "t",
      desc = "New terminal",
    },
    {
      "<leader>l",
      "<cmd>FloatermNext<CR>",
      mode = "t",
      desc = "Next terminal",
    },
    {
      "<leader>h",
      "<cmd>FloatermPrev<CR>",
      mode = "t",
      desc = "Previous terminal",
    },
  },
}

M.nvim_possession = {
  keys = {
    {
      "<leader>Sl",
      function()
        require("nvim-possession").list()
      end,
      mode = "n",
      desc = "List sessions",
    },
    {
      "<leader>Sn",
      function()
        require("nvim-possession").new()
      end,
      mode = "n",
      desc = "New session",
    },
    {
      "<leader>Su",
      function()
        require("nvim-possession").update()
      end,
      mode = "n",
      desc = "Update session",
    },
    {
      "<leader>Sd",
      function()
        require("nvim-possession").delete()
      end,
      mode = "n",
      desc = "Delete session",
    },
  },
}

return M
