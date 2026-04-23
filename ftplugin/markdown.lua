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
    local bufnr = vim.api.nvim_get_current_buf()
    local keymaps = require("kaivim.config.keymaps")
    local wk_ok, wk = pcall(require, "which-key")
    for _, map in ipairs(keymaps.obsidian.bufkeys) do
      if wk_ok then
        wk.add({ vim.tbl_extend("force", map, { buffer = bufnr }) })
      else
        vim.keymap.set(map.mode, map[1], map[2], {
          buffer = bufnr,
          desc = map.desc,
        })
      end
    end
  end
end

