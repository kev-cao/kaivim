--- @module 'kaivim.config.general'
--- This contains general settings that don't fit into any other category

vim.g.rust_recommended_style = 0
--- Temporary fix for diffget not replacing entire conflict. See issue:
--- https://github.com/neovim/neovim/issues/22696
vim.opt.diffopt:remove("linematch:40")

vim.opt.backupcopy = "yes"
vim.opt.colorcolumn = { "80", "100" }
vim.opt.hlsearch = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.textwidth = 80
vim.opt.formatoptions = "cqj"
vim.opt.ruler = true
vim.opt.cmdheight = 1
vim.opt.updatetime = 750
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.guicursor = "n-v-c-sm:block-blinkwait100-blinkoff20-blinkon20,"
  .. "i-ci-ve:ver25-blinkwait100-blinkoff20-blinkon20,"
  .. "r-cr-o:hor20-blinkwait100-blinkoff20-blinkon20"
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ssop:append({ "curdir" })
vim.opt.ssop:remove("blank")
vim.opt.conceallevel = 2
vim.opt.autoread = true

vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
vim.g.vimtex_quickfix_ignore_filters = {
  "Underfull",
  "Overfull",
  "does not make sense",
  "Non standard sectioning",
}

vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Create the Terminal command using the API.
vim.api.nvim_create_user_command("Terminal", "botright vs | term", {})

-- Set up command-line abbreviations.
vim.cmd("cabbrev terminal Terminal")
vim.cmd("cabbrev term Terminal")

vim.diagnostic.config({
  virtual_text = true,
})
