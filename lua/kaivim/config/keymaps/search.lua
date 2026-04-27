local M = {}

M.fzf = {
  keys = {
    {
      "<leader>sf",
      "<cmd>FzfLua files<CR>",
      mode = "n",
      desc = "Search files",
    },
    {
      "<leader>sb",
      "<cmd>FzfLua buffers<CR>",
      mode = "n",
      desc = "Search buffers",
    },
    {
      "<leader>sm",
      "<cmd>FzfLua marks<CR>",
      mode = "n",
      desc = "Search marks",
    },
    {
      "<leader>sr",
      "<cmd>FzfLua live_grep<CR>",
      mode = "n",
      desc = "Live search in project",
    },
    {
      "<leader>sp",
      "<cmd>FzfLua live_grep resume=true<CR>",
      mode = "n",
      desc = "Resume previous live search",
    },
    {
      "<localleader>s",
      "<cmd>FzfLua blines<CR>",
      mode = "n",
      desc = "Search in current buffer",
    },
    {
      "<leader>sq",
      "<cmd>FzfLua loclist<CR>",
      mode = "n",
      desc = "Search location list",
    },
    {
      "<leader>s<S-q>",
      "<cmd>FzfLua quickfix<CR>",
      mode = "n",
      desc = "Search quickfix list",
    },
    {
      "<leader>sj",
      "<cmd>FzfLua jumps<CR>",
      mode = "n",
      desc = "Search jumplist",
    },
    {
      "<leader>gc",
      -- Prevent FzF from sorting the output so that local branches
      -- are listed first.
      "<cmd>FzfLua git_branches fzf_opts.--no-sort=true<CR>",
      mode = "n",
      desc = "List git branches",
    },
  },
  fzfkeys = {
    ["tab"] = "down",
    ["shift-tab"] = "up",
  },
}

M.neoclip = {
  keys = {
    {
      "<leader>sy",
      function()
        require("neoclip.fzf")()
      end,
      mode = "n",
      desc = "Search clipboard history",
    },
  },
}

return M
