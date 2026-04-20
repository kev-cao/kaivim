--- @module 'plugins.lang.lsp.rust'
--- This module configures the Rust language server and related plugins for
--- Neovim.

--- @type LspSpec
return {
  lsp = nil,
  ft = { "rust" },
  formatter = { "rustfmt" },
  linter = {
    clippy = nil
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^7', -- Recommended
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = "all",
              }
            }
          }
        }
      }
    end,
  },
}
