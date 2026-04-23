local func = require("kaivim.util.func")
local keymaps = require("kaivim.config.keymaps")
func.apply_bufkeys(vim.api.nvim_get_current_buf(), keymaps.neotest["output-panel"])
