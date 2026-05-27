--- @module 'plugins.lang.lsp.go'
--- This module configures the Go language server and related plugins for
--- Neovim.

--- @type LspSpec
return {
  lsp = {
    gopls = {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      single_file_support = true,
      capabilities = {
        offsetEncoding = "utf-16",
      },
      settings = {
        gopls = {
          buildFlags = { "-mod=mod" },
          directoryFilters = {
            "-**/node_modules",
            "-**/_bazel",
            "-**/bazel-bin",
            "-**/bazel-out",
            "-**/bazel-testlogs",
            "-**/vendor",
            "-**/inflight_trace_dump",
            "-pkg/sql/colexec",
          },
          semanticTokens = true,
          staticcheck = true,
          hints = {
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
            ignoredError = true,
          },
          completeUnimported = true,
          deepCompletion = true,
          usePlaceholders = false,
          diagnosticsDelay = "250ms",
          analyses = {
            unusedparams = true,
            nilness = true,
            unusedwrite = true,
            unusedvariable = true,
            SA4006 = true,
          },
        },
      },
    },
  },
  ft = {"go"},
  linter = {
    golangcilint = nil
  },
  formatter = function()
    local gofmt = "gofmt"
    if vim.fn.executable("crlfmt") == 1 then
      gofmt = "crlfmt"
    end
    return { "goimports", gofmt }
  end,
  {
    "charlespascoe/vim-go-syntax",
    ft = { "go", "gomod", "gowork", "gotmpl" },
  },
}
