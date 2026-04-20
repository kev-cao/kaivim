--- @module "plugins.lang.lint"
--- This module configures linters for Neovim.

local plugins = require("kaivim.util.plugins")

return {
  {
    "mfussenegger/nvim-lint",
    branch = "master",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local opts = {
        linters_by_ft = {},
      }
      local lsp_specs = plugins.get_lsp_specs()
      for _, spec in ipairs(lsp_specs) do
        if spec.linter then
          local linters = {}
          for linter, _ in pairs(spec.linter) do
            table.insert(linters, linter)
          end
          for _, ft in ipairs(spec.ft or {}) do
            opts.linters_by_ft[ft] = linters
          end
        end
      end
      return opts
    end,
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft or {}

      local lsp_specs = plugins.get_lsp_specs()
      for _, spec in ipairs(lsp_specs) do
        if spec.linter then
          for linter, lint_cfg in pairs(spec.linter) do
            local default_cfg = lint.linters[linter] or {}
            if type(lint_cfg) == "function" then
              lint.linters[linter] = function()
                return lint_cfg(default_cfg)
              end
            elseif type(lint_cfg) == "table" then
              for key, value in pairs(lint_cfg) do
                lint.linters[linter][key] = value
              end
            end
          end
        end
      end
    end,
  },
}
