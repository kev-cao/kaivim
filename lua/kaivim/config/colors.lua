--- @module 'kaivim.config.colors'
--- Contains general UI color settings

vim.api.nvim_set_hl(0, "Search", { bg = "#75819c", ctermbg = 67, fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "CurSearch", { bg = "#75819c", ctermbg = 67, fg = "#000000" })
vim.api.nvim_set_hl(0, "IncSearch", { link = "Search" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#C3EEFF", ctermfg = 51 })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE", underline = false })
