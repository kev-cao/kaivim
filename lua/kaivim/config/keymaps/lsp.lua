local M = {}

M.lsp = {
  keys = {
    {
      "gd",
      "<cmd>FzfLua lsp_definitions<CR>",
      mode = "n",
      desc = "Go to definition",
    },
    {
      "gi",
      "<cmd>FzfLua lsp_implementations<CR>",
      mode = "n",
      desc = "List implementations",
    },
    {
      "gr",
      "<cmd>FzfLua lsp_references<CR>",
      mode = "n",
      desc = "List references",
    },
    {
      "gt",
      "<cmd>FzfLua lsp_typedefs<CR>",
      mode = "n",
      desc = "Go to type definition",
    },
    {
      "<leader>rr",
      "<cmd>lua vim.lsp.buf.rename()<CR>",
      mode = "n",
      desc = "Rename reference",
    },
    {
      "<M-k>",
      "<cmd>lua vim.lsp.buf.hover()<CR>",
      mode = "n",
      desc = "Show documentation",
    },
    {
      "<M-k>",
      "<cmd>lua vim.lsp.buf.signature_help()<CR>",
      mode = "i",
      desc = "Show signature",
    },
    {
      "<localleader>d",
      "<cmd>FzfLua diagnostics_document<CR>",
      mode = "n",
      desc = "Show buffer diagnostics",
    },
    {
      "<leader>ld",
      "<cmd>FzfLua diagnostics_workspace<CR>",
      mode = "n",
      desc = "Show workspace diagnostics",
    },
    {
      "<localleader>j",
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      mode = "n",
      desc = "Next diagnostic",
    },
    {
      "<localleader>k",
      "<cmd>lua vim.diagnostic.goto_prev()<CR>",
      mode = "n",
      desc = "Previous diagnostic",
    },
    {
      "<leader>lc",
      "<cmd>FzfLua lsp_code_actions<CR>",
      mode = "n",
      desc = "Code actions",
    },
    {
      "<leader>l<S-s>",
      "<cmd>FzfLua lsp_live_workspace_symbols<CR>",
      mode = "n",
      desc = "Live workspace symbols",
    },
    {
      "<localleader><S-s>",
      "<cmd>FzfLua treesitter<CR>",
      mode = "n",
      desc = "List buffer symbols",
    },
    {
      "<leader>lh",
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
      end,
      mode = "n",
      desc = "Toggle inlay hints",
    },
  },
}

return M
