local general = require("kaivim.config.keymaps.general")
local search = require("kaivim.config.keymaps.search")
local workspace = require("kaivim.config.keymaps.workspace")
local fs = require("kaivim.config.keymaps.fs")
local git = require("kaivim.config.keymaps.git")
local editor = require("kaivim.config.keymaps.editor")
local ui = require("kaivim.config.keymaps.ui")
local ai = require("kaivim.config.keymaps.ai")
local dev = require("kaivim.config.keymaps.dev")
local notes = require("kaivim.config.keymaps.notes")
local lsp = require("kaivim.config.keymaps.lsp")
--- @class KeyMap
--- @field keys LazyKeysSpec[]
--- @field bufkeys? LazyKeysSpec[]
--- @field bufgroups? wk.Spec[]

--- @alias PluginKeyMaps table<string, KeyMap>

--- @type table<string, { keys?: LazyKeysSpec[], bufkeys?: LazyKeysSpec[], bufgroups?: wk.Mapping[] }>
local M = {}

M.groups = {
  { "gp", group = "Goto with preview", icon = { icon = "", color = "green" } },
  { "<leader>s", group = "Search" },
  { "<leader>g", group = "Git", icon = { icon = "", color = "green" } },
  { "<localleader>g", group = "Git", icon = { icon = "", color = "green" } },
  { "<leader>d", group = "Debugger", icon = { icon = "󰨰", color = "blue" } },
  { "<leader><S-t>", group = "Tests", icon = { icon = "", color = "blue" } },
  { "<leader>t", group = "Terminal" },
  { "<leader>m", group = "Marks", icon = { icon = "", color = "yellow" } },
  { "<localleader>m", group = "Marks", icon = { icon = "", color = "yellow" } },
  { "<leader>mb", group = "Bookmarks", icon = { icon = "", color = "purple" } },
  { "<leader>mbl", group = "List bookmarks in group [0-9]", icon = { icon = "", color = "blue" } },
  { "<leader>mb<C-d>", group = "Delete all bookmarks in group [0-9]", icon = { icon = "󰛌", color = "red" } },
  { "<leader>m<S-j>", group = "Next bookmark in group [0-9]", icon = { icon = "󰒭", color = "green" } },
  { "<leader>m<S-k>", group = "Previous bookmark in group [0-9]", icon = { icon = "󰒮", color = "green" } },
  { "<leader>l", group = "LSP", icon = { icon = "", color = "red" } },
  { "<leader>c", group = "Claude AI", icon = { icon = "󱚤", color = "green" } },
  { "<leader>S", group = "Sessions", icon = { icon = "󱫭", color = "green" } },
  { "<leader>f", group = "Filesystem", icon = { icon = "", color = "green" } },
}

-- Merge all sub-modules into M
local modules = {
  general,
  search,
  workspace,
  fs,
  git,
  editor,
  ui,
  ai,
  dev,
  notes,
  lsp,
}

for _, mod in ipairs(modules) do
  for k, v in pairs(mod) do
    M[k] = v
  end
end

return M
