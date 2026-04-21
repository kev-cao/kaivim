--- @module "kaivim"
--- Entry point for the KaiVim distribution.

local M = {}

--- @class KaiVimConfig
--- @field ai_assistant? "claude"|"opencode" Which AI assistant to enable (default: nil, both disabled)

--- @type KaiVimConfig
M.config = {
  ai_assistant = nil,
}

--- Sets up the KaiVim distribution with the given options.
--- When used as a lazy.nvim plugin, opts from vim.g.kaivim_opts are also
--- merged (set this global before lazy.setup() so that plugin specs can
--- read config values during evaluation).
--- @param opts? KaiVimConfig
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, vim.g.kaivim_opts or {}, opts or {})

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
