local keymaps = require("kaivim.config.keymaps")

--- @class LspSpec
--- @field ft string[] Filetypes that linters and formatters will apply to (output of vim.bo.filetype)
--- @field lsp? table<string, vim.lsp.Config|nil> Mapping of LSPs to their options, or nil for defaults.
--- @field linter? table<string, PartialLinter|(fun(lint.Linter): lint.Linter)|nil> Linters to use mapped to their configuration, or nil for defaults. If a function is provided, the default linter configuration is passed to the function.
--- @field formatter? conform.FiletypeFormatter Formatters to use


--- @class (partial) PartialLinter: lint.Linter

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "junegunn/fzf",
    },
    opts = function()
      local opts = {
        capabilities = {},
        servers = {},
      }
      local plugins = require("kaivim.util.plugins")
      local lsp_specs = plugins.get_lsp_specs()
      for _, spec in pairs(lsp_specs) do
        for lsp, lsp_opts in pairs(spec.lsp or {}) do
          if lsp_opts ~= nil then
            opts.servers[lsp] = lsp_opts
          end
        end
      end
      return opts
    end,
    config = function(_, opts)
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        opts.capabilities or {}
      )

      vim.lsp.config("*", { capabilities = capabilities })

      -- Collect per-server on_attach hooks, then strip them from the config
      -- since vim.lsp.config does not support on_attach directly.
      local server_on_attaches = {}
      for server_name, server in pairs(opts.servers) do
        if server.on_attach then
          server_on_attaches[server_name] = server.on_attach
          server = vim.deepcopy(server)
          server.on_attach = nil
        end
        vim.lsp.config(server_name, server)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kaivim_lsp_attach", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then return end

          -- Run per-server on_attach if defined
          local on_attach = server_on_attaches[client.name]
          if on_attach then
            on_attach(client, ev.buf)
          end

          -- Highlight references under cursor
          if client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup("kaivim_lsp_highlight_" .. ev.buf, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = ev.buf,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = ev.buf,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
    keys = keymaps.lsp.keys,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = true,
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },
}
