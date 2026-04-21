--- @module "kaivim.util.plugins"
--- This module provides utility functions for navigating the plugins directory
--- in this Neovim configuration.

local M = {}

-- Resolve the root of the kaivim lua package relative to this file.
-- debug.getinfo(1, "S").source gives the path to this file;
-- :h:h:h strips util/ -> kaivim/ -> lua/kaivim's parent, landing on lua/.
local my_root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h:h")

--- Scans a directory for LspSpec lua files and appends them to the specs table.
--- @param dir string The directory to scan.
--- @param module_prefix string The Lua module prefix for requiring files.
--- @param specs LspSpec[] The table to append specs to.
--- @param skip? table<string, boolean> Module names to skip.
local function scan_lsp_dir(dir, module_prefix, specs, skip)
  local uv = vim.loop
  local fd = uv.fs_opendir(dir, nil, 1000)
  if not fd then
    return
  end
  local stats = uv.fs_readdir(fd)
  if not stats then
    return
  end

  for _, stat in ipairs(stats) do
    if stat.type ~= "file" then
      goto continue
    end
    local module_name = stat.name:match("^(.*)%.lua$")
    if not module_name or (skip and skip[module_name]) then
      goto continue
    end

    local full_module = module_prefix .. "." .. module_name
    local ok, module = pcall(require, full_module)
    if not ok then
      vim.notify(
        "Failed to load module " .. full_module .. ": " .. module,
        vim.log.levels.ERROR
      )
      goto continue
    end
    if type(module) ~= "table" then
      vim.notify(
        "Module " .. full_module .. " did not return a table",
        vim.log.levels.ERROR
      )
      goto continue
    end

    table.insert(specs, module)
    ::continue::
  end
end

--- Gets all language specific specs from the distribution's lang/lsp directory
--- and the user's config lang/lsp directory.
--- @return LspSpec[]
function M.get_lsp_specs()
  local specs = {}
  scan_lsp_dir(
    my_root .. "/kaivim/plugins/lang/lsp",
    "kaivim.plugins.lang.lsp",
    specs,
    { lsp = true }
  )
  scan_lsp_dir(
    vim.fn.stdpath("config") .. "/lua/lang/lsp",
    "lang.lsp",
    specs
  )
  return specs
end

--- Generates import specifications for all init.lua files found in the
--- subdirectories of the given subdirectory.
--- @param dir string The subdirectory in plugins/ to search.
--- @return _ table A table merging all import specifications found in each
local function generate_import_specs(dir)
  local uv = vim.loop
  local stats = uv.fs_readdir(uv.fs_opendir(my_root .. "/kaivim/plugins/" .. dir, nil, 1000))
  if not stats then
    return
  end

  local import_specs = {}
  for _, stat in ipairs(stats) do
    if stat.type == "directory" then
      local recursed_specs = generate_import_specs(dir .. "/" .. stat.name)
      vim.tbl_extend("error", import_specs, recursed_specs)
    end

    if stat.name ~= "init.lua" or dir == "" then
      goto continue
    end

    local init_path = "kaivim.plugins." .. dir .. ".init"
    local ok, module = pcall(require, init_path)
    if not ok then
      vim.notify(
        "Failed to load module " .. init_path .. ": " .. module,
        vim.log.levels.ERROR
      )
      goto continue
    end
    if type(module) ~= "table" then
      vim.notify(
        "Module " .. init_path .. " did not return a table",
        vim.log.levels.ERROR
      )
      goto continue
    end

    vim.tbl_extend("error", import_specs, module)
    ::continue::
  end

  return import_specs
end


--- Looks for init.lua files in plugin/ subdirectories and generates import
--- specifications for them.
--- @return _ table A table merging all import specifications found in each
--- plugin subdirectory.
function M.generate_plugin_import_specs()
  return generate_import_specs("")
end

return M
