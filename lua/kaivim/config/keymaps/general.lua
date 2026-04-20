local keymaps = require("kaivim.util.keymaps")

local M = {}

M.general = {
  keys = {
    {
      "<leader>,",
      ",",
      mode = "n",
    },
    {
      "<C-w>x",
      "<cmd>tabclose<CR>",
      mode = { "n", "i", "v" },
      desc = "Close tab",
    },
    {
      "<C-w>t",
      "<cmd>tabnew<CR>",
      mode = { "n", "i", "v" },
      desc = "Create new tab",
    },
    {
      "<C-Tab>",
      "<cmd>tabn<CR>",
      mode = { "n", "t" },
      desc = "Next tab",
    },
    {
      "<C-S-Tab>",
      "<cmd>tabp<CR>",
      mode = { "n", "t" },
      desc = "Previous tab",
    },
    {
      "<S-Up>",
      "<cmd>resize +2<CR>",
      mode = { "n", "i", "v" },
      desc = "Increase window height",
    },
    {
      "<S-Down>",
      "<cmd>resize -2<CR>",
      mode = { "n", "i", "v" },
      desc = "Decrease window height",
    },
    {
      "<S-Right>",
      "<cmd>vertical resize +2<CR>",
      mode = { "n", "i", "v" },
      desc = "Increase window width",
    },
    {
      "<S-Left>",
      "<cmd>vertical resize -2<CR>",
      mode = { "n", "i", "v" },
      desc = "Decrease window width",
    },
    -- Rebind macro recording to <M-q> to avoid accidentally recording macros
    {
      "q",
      "<nop>",
      hidden = true,
      mode = "n",
    },
    {
      "<M-q>",
      "q",
      hidden = true,
      mode = "n",
    },
    {
      "<C-w>",
      "<C-\\><C-n><C-w>",
      mode = "t",
    },
    {
      "<M-l>",
      "<cmd>nohlsearch | diffupdate | normal! <C-l><CR>",
      mode = { "n", "i", "v" },
      desc = "Clear highlights and redraw screen",
    },
    {
      "<localleader>gh",
      keymaps.git.copy_git_hash,
      mode = "n",
      desc = "Copy git blame hash for current line",
    },
    {
      "<C-g>",
      keymaps.copy_current_filepath,
      mode = { "n", "i", "v" },
      desc = "Copy current file path to clipboard",
    },
    --- Disable Ctrl-o in terminal mode. Claude code uses Ctrl-o as
    --- one of its keybindings.
    {
      "<C-o>",
      "<C-\\><C-n>i<C-o>",
      mode = "t",
      hidden = true,
      noremap = true,
    },
  },
}

return M
