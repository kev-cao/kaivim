--- @module 'plugins.git'
--- Git related plugins

local keymaps = require("kaivim.config.keymaps")

return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
    },
    keys = keymaps.octo.keys,
    opts = {
      picker = "fzf-lua",
      mappings_disable_default = false,
      mappings = keymaps.octo.bufkeys,
    },
    config = function(_, opts)
      require("octo").setup(opts)
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    init = function()
      vim.g.lazygit_use_custom_config_file_path = 1
      vim.g.lazygit_config_file_path = vim.fn.expand("$HOME/.config/lazygit/config.yml")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    keys = keymaps.lazygit.keys,
  },
  {
    "tpope/vim-fugitive",
    keys = keymaps.fugitive.keys,
  },
  {
    "tpope/vim-rhubarb",
    dependencies = {
      { "tpope/vim-fugitive" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    keys = keymaps.gitsigns.keys,
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },
}
