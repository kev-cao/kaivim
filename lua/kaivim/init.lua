--- @module "kaivim"
--- Entry point for the KaiVim distribution.

local M = {}

--- Sets up the KaiVim distribution.
function M.setup()
  require("kaivim.config.general")
  require("kaivim.config.autocmds")

  local keymaps = require("kaivim.config.keymaps")
  for _, key in ipairs(keymaps.general.keys) do
    vim.keymap.set(
      key.mode,
      key[1],
      key[2],
      vim.tbl_deep_extend("force", { noremap = true, silent = true, desc = key.desc }, key.opts or {})
    )
  end

  -- Apply general highlight overrides after each colorscheme change so they
  -- aren't overwritten by the theme.
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      require("kaivim.config.colors")
    end,
  })
end

return M
