--- @module 'plugins.lang.lsp.proto'
--- This module configures the Protobuf language server and related plugins for
--- Neovim.

--- @type LspSpec
return {
  ft = { "proto" },
  linter = {
    protolint = {}
  },
  formatter = { "buf" },
}
