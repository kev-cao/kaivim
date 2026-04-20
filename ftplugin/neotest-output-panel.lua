local func = require("kaivim.util.func")
local keymaps = require("kaivim.config.keymaps")

local ok, wk = pcall(require, "which-key")
if ok then
  wk.add(func.make_buflocal(keymaps.neotest["output-panel"]))
else
  for _, map in ipairs(keymaps.neotest["output-panel"]) do
    vim.keymap.set(map.mode, map[1], map[2], {
      buffer = 0,
      desc = map.desc,
    })
  end
end
