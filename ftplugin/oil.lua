local func = require("kaivim.util.func")
local keymaps = require("kaivim.config.keymaps")

local ok, wk = pcall(require, "which-key")
if ok then
  wk.add(func.make_buflocal(keymaps.oil.bufkeys))
else
  for _, map in ipairs(keymaps.oil.bufkeys) do
    vim.keymap.set(map.mode, map[1], map[2], {
      buffer = 0,
      desc = map.desc,
    })
  end
end

vim.api.nvim_set_hl(0, "WinBar", { bg = "#31353f", bold = true })
