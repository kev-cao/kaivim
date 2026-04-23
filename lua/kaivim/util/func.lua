--- @module "kaivim.util.func"
--- Offers utility functions

local M = {}

--- Capitalizes the first letter of a string and lowercases the rest.
--- @param str string The string to capitalize.
--- @return string|nil The capitalized string, or nil if the input is empty.
function string.capitalize(str)
  if str == "" then
    return
  end
  local first = str:sub(1, 1)
  local last = str:sub(2)
  return first:upper() .. last:lower()
end

--- Display text in a centered unmodifiable floating window.
--- @param txt_tbl table: Table of strings to display in the floating window.
--- @param height number: Height of the floating window.
--- @param width number: Width of the floating window.
--- @param opts table: Additional options for the floating window.
function M.display_in_float(txt_tbl, height, width, opts)
  local ui_height, ui_width = M.get_ui_dimensions()
  local buf = vim.api.nvim_create_buf(false, true)
  opts = vim.tbl_deep_extend("force", opts or {}, {
    relative = "editor",
    width = width,
    height = height,
    col = ui_width / 2 - width / 2,
    row = ui_height / 2 - height / 2,
    anchor = "NW",
    style = "minimal",
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  })
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_set_option_value("cursorline", true, { win = win })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, txt_tbl)
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true, nowait = true })
  vim.api.nvim_set_option_value("readonly", true, { buf = buf })
  vim.api.nvim_set_option_value("modified", false, { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end

--- Returns the current UI dimensions (terminal rows and columns).
--- @return number height The number of terminal rows.
--- @return number width The number of terminal columns.
function M.get_ui_dimensions()
  local h = vim.api.nvim_exec2("echo &lines", { output = true }).output
  local w = vim.api.nvim_exec2("echo &columns", { output = true }).output
  local height = tonumber(h) or 0
  local width = tonumber(w) or 0
  return height, width
end

--- Registers buffer-local keymaps and optionally which-key groups.
--- @param bufnr number Buffer number to apply keymaps to.
--- @param keys LazyKeysSpec[] Array of keymap specs.
--- @param groups? wk.Spec[] Optional which-key group specs (only applied if which-key is available).
function M.apply_bufkeys(bufnr, keys, groups)
  local wk_ok, wk = pcall(require, "which-key")
  if wk_ok and groups then
    for _, group in ipairs(groups) do
      wk.add({ vim.tbl_extend("force", group, { buffer = bufnr }) })
    end
  end
  for _, map in ipairs(keys) do
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

--- Checks if the current working directory is inside a git repository.
--- @return boolean: True if inside a git repository, false otherwise.
function M.in_git_repo()
  local _ = vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

--- Checks if the current git repository has merge conflicts.
--- @return boolean: True if there are merge conflicts, false otherwise.
--- Only works if inside a git repository. Call in_git_repo() first.
function M.has_merge_conflicts()
  local result = vim.fn.systemlist({ "git", "ls-files", "-u" })
  return #result > 0
end

return M
