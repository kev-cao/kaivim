local func = require("kaivim.util.func")
local keymaps = require("kaivim.config.keymaps")

vim.cmd("setlocal textwidth=0")
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add(func.make_buflocal(keymaps.octo.bufgroups))
end
