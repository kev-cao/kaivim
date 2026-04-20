--- @module 'plugins.workspace'
--- Terminal and session plugins

local keymaps = require("kaivim.config.keymaps")

return {
  {
    "voldikss/vim-floaterm",
    keys = keymaps.floaterm.keys,
    init = function()
      vim.g.floaterm_wintype = "split"
      vim.g.floaterm_position = "botright"
      vim.g.floaterm_height = 0.2
    end,
  },
  {
    "gennaro-tedesco/nvim-possession",
    dependencies = {
      "ibhagwan/fzf-lua",
    },

    build = function()
      os.execute("mkdir -p " .. vim.fn.stdpath("data") .. "/.sessions")
    end,
    lazy = false,
    keys = keymaps.nvim_possession.keys,
    config = true,
    opts = {
      fzf_winopts = {
        title = "󱫭 Search Sessions",
      },
      sessions = {
        sessions_path = vim.fn.stdpath("data") .. "/.sessions/",
        sessions_icon = "󱫭 ",
      },
      autosave = true,
      autoload = true,
      autoprompt = true,
      autoswitch = {
        enable = true,
      },
      save_hook = function()
        if pcall(require, "nvim-tree") then
          vim.cmd("NvimTreeFocus")
          vim.cmd("silent! bd")
        end
        -- Get visible buffers
        local visible_buffers = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          visible_buffers[vim.api.nvim_win_get_buf(win)] = true
        end

        local buflist = vim.api.nvim_list_bufs()
        for _, bufnr in ipairs(buflist) do
          if visible_buffers[bufnr] == nil then -- Delete buffer if not visible
            vim.cmd("silent! bd " .. bufnr)
            goto continue
          end

          -- Also delete ClaudeCode/OpenCode buffers since they should not saved.
          local is_terminal = vim.bo[bufnr].buftype == "terminal"
          if not is_terminal then
            goto continue
          end

          local name = vim.api.nvim_buf_get_name(bufnr)
          local filetype = vim.bo[bufnr].filetype
          if name:match("claude%-code%-") or filetype == "opencode_terminal" then
            pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
          end

          ::continue::
        end
      end,
    },
  },
}
