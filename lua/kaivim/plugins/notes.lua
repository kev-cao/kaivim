--- @module 'plugins.notes'
--- Note-taking plugin configuration

return {
  {
    "kev-cao/kai-obsidian.nvim",
    dependencies = {
      "obsidian-nvim/obsidian.nvim",
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
    },
    event = "VeryLazy",
    keys = require("kaivim.config.keymaps").obsidian.keys,
    opts = {
      obsidian = {
        ui = { enable = false }, -- disabled in favor of render-markdown
      },
    },
    config = function(_, opts)
      require("kai-obsidian").setup(opts)

      -- Apply kaivim's own buffer-local keymaps to vault markdown files.
      local vault = tostring(Obsidian.dir)
      local func = require("kaivim.util.func")
      local keymaps = require("kaivim.config.keymaps")

      local function apply(bufnr)
        func.apply_bufkeys(bufnr, keymaps.obsidian.bufkeys, keymaps.obsidian.bufgroups)
      end

      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { vault .. "/*.md", vault .. "/**/*.md" },
        group = vim.api.nvim_create_augroup("kaivim_obsidian_bufkeys", { clear = true }),
        callback = function(ev) apply(ev.buf) end,
      })

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        if vim.api.nvim_buf_is_loaded(buf) and name:find(vault, 1, true) == 1 and name:match("%.md$") then
          apply(buf)
        end
      end
    end,
  },
}
