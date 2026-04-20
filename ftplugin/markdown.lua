vim.cmd("setlocal textwidth=100")

-- Disable auto line breaking in Claude prompt buffers since it gets annoying.
local curr_file = vim.fn.expand("%:p")
if curr_file:match("claude%-prompt%-") then
  vim.cmd("setlocal textwidth=0")
end
