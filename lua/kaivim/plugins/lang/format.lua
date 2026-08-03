--- @module "plugins.lang.format"
--- This module configures formatters for Neovim.

return {
  {
    "stevearc/conform.nvim",
    opts = function()
      --- @type conform.setupOpts
      local opts = {
        formatters_by_ft = {
          ["*"] = { "trim_whitespace" },
        },
        formatters = {
          crlfmt = {
            command = "crlfmt",
            args = {
              "-tab=2",
              "-wrap=100",
              "-ignore", "'.(pb(.gw)?)|(\\.[eo]g)\\.go|/testdata/|^sql/parser/sql\\.go$|_generated(_test)?\\.go$'",
              "-w", "$FILENAME",
            },
            stdin = false,
            inherit = false,
          },
        },
        log_level = vim.log.levels.INFO,
      }
      local lsp_specs = require("kaivim.util.plugins").get_lsp_specs()
      for _, spec in ipairs(lsp_specs) do
        local fmtrs = spec.formatter
        if fmtrs ~= nil then
          if type(spec.formatter) == "function" then
            fmtrs = spec.formatter()
          end

          local fmtr_names = {}
          for ft, _ in pairs(fmtrs) do
            table.insert(fmtr_names, ft)
          end

          for _, ft in ipairs(spec.ft or {}) do
            opts.formatters_by_ft[ft] = fmtr_names
          end

          --- @type string[]
          for formatter, cfg in pairs(fmtrs) do
            if opts.formatters[formatter] == nil then
              opts.formatters[formatter] = cfg
            end
          end
        end
      end

      -- Always write to /tmp for any tempfiles
      for _, formatter in pairs(opts.formatters) do
        formatter.tmpfile_format =  "/tmp/.conform.$RANDOM.$FILENAME"
      end

      return opts
    end
  }
}
