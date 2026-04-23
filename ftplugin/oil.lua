local func = require("kaivim.util.func")
local keymaps = require("kaivim.config.keymaps")
func.apply_bufkeys(vim.api.nvim_get_current_buf(), keymaps.oil.bufkeys)

vim.api.nvim_set_hl(0, "WinBar", { bg = "#31353f", bold = true })
