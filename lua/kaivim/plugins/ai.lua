--- @module 'plugins.ai'
--- All AI related plugins

local keymaps = require("kaivim.config.keymaps")

return {
  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    keys = keymaps.copilot.keys,
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
    },
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = keymaps.claude.keys,
    opts = {
      command = "claude",
      window = {
        split_ratio = 0.3,
        position = "vertical botright",
      }
    },
    enabled = function()
      local opts = vim.g.kaivim_opts or require("kaivim").config
      return opts.ai_assistant == "claude"
    end,
    config = function(_, opts)
      require("claude-code").setup(opts)
    end
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    keys = keymaps.opencode.keys,
    enabled = function()
      local opts = vim.g.kaivim_opts or require("kaivim").config
      return opts.ai_assistant == "opencode"
    end,
    init = function()
      vim.o.autoread = true
    end,
  }
}
