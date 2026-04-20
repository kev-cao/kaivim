--- @module "kaivim.util.oil"
--- This module provides helper functions for oil.nvim

local M = {}

--- Returns the winbar text for an oil.nvim buffer, showing the directory path
--- relative to the current working directory or home directory.
--- @return string The directory path or buffer name for the winbar.
function M.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~:.")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return M
