vim.cmd("setlocal textwidth=100")

local curr_file = vim.fn.expand("%:p")

-- Disable auto line breaking in Claude prompt buffers since it gets annoying.
if curr_file:match("claude%-prompt%-") then
  vim.cmd("setlocal textwidth=0")
end
