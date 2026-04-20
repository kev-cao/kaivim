--- @module "plugins.lang.lsp.ts"
--- This module configures the the TypeScript language server for Neovim and
--- related plugins.

--- @type LspSpec
return {
  lsp = {
    tsserver = nil,
  },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  formatter = { "prettier" },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
  },
}
