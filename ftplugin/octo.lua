local func = require("kaivim.util.func")
local keymaps = require("kaivim.config.keymaps")

vim.cmd("setlocal textwidth=0")
func.apply_bufkeys(vim.api.nvim_get_current_buf(), {}, keymaps.octo.bufgroups)
