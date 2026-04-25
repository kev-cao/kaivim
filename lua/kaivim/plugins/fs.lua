--- @module 'plugins.fs'
--- All file system related plugins

local keymaps = require("kaivim.config.keymaps")

return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      -- Nerd fonts for icons
      "nvim-tree/nvim-web-devicons",
    },
    keys = keymaps.nvim_tree.keys,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.g.nvim_tree_width = 30
    end,
    lazy = false,
    opts = function()
      local api = require("nvim-tree.api")
      return {
        on_attach = function(bufnr)
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          api.map.on_attach.default(bufnr)

          for _, mapping in ipairs(keymaps.nvim_tree.bufkeys) do
            local lhs = mapping[1]
            local rhs = mapping[2]
            local mode = mapping.mode
            local desc = mapping.desc or ""
            vim.keymap.set(mode, lhs, rhs, opts(desc))
          end
        end
      }
    end
  },
  {
    'stevearc/oil.nvim',
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      use_default_keymaps = false,
      skip_confirm_for_simple_edits = true,
      win_options = {
        winbar = "%!v:lua.require('kaivim.util.oil').get_oil_winbar()",
      },
      extra_scp_args = { "-O" }, -- Forces legacy protocol
    },
    keys = keymaps.oil.keys,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  }
}
