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
  -- AI assistants are disabled by default because they share the same
  -- keybindings. Enable one in your own plugin specs (e.g. lua/plugins/ai.lua).
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
    enabled = false,
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    keys = keymaps.opencode.keys,
    enabled = false,
    init = function()
      vim.o.autoread = true
    end,
  }
}
