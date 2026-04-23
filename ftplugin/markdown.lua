vim.cmd("setlocal textwidth=100")

local curr_file = vim.fn.expand("%:p")

-- Disable auto line breaking in Claude prompt buffers since it gets annoying.
if curr_file:match("claude%-prompt%-") then
  vim.cmd("setlocal textwidth=0")
end

-- Apply obsidian.nvim buffer-local keymaps for vault markdown files
local ok, obsidian = pcall(function() return Obsidian end)
if ok and obsidian and obsidian.dir then
  local vault = tostring(obsidian.dir)
  if curr_file:find(vault, 1, true) == 1 then
    local func = require("kaivim.util.func")
    local keymaps = require("kaivim.config.keymaps")
    func.apply_bufkeys(vim.api.nvim_get_current_buf(), keymaps.obsidian.bufkeys, keymaps.obsidian.bufgroups)
  end
end

