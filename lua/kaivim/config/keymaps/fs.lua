local M = {}

M.nvim_tree = {
  keys = {
    {
      "<C-n>",
      "<cmd>NvimTreeFocus<CR>",
      mode = "n",
      desc = "Focus on nvim-tree",
    },
    {
      "<C-b>",
      "<cmd>NvimTreeToggle<CR>",
      mode = "n",
      desc = "Toggle nvim-tree",
    },
    {
      "<C-f>",
      "<cmd>NvimTreeFindFile<CR>",
      mode = "n",
      desc = "Find file in nvim-tree",
    },
  },
  bufkeys = {
    {
      "<C-\\>",
      function()
        require("nvim-tree.api").node.open.vertical()
      end,
      mode = "n",
      desc = "Open: Vertical Split",
    },
  },
}

M.oil = {
  keys = {
    {
      "<leader>f",
      function()
        local oil = require("oil")
        oil.toggle_float(".")
      end,
      mode = "n",
      desc = "Toggle Oil explorer in cwd",
    },
    {
      "<localleader>f",
      function()
        local oil = require("oil")
        oil.toggle_float(nil)
      end,
      mode = "n",
      desc = "Toggle Oil explorer in current buffer's dir",
    }
  },
  bufkeys = {
    {
      "<CR>",
      function()
        local oil = require("oil")
        oil.select()
      end,
      mode = "n",
      desc = "Open file or directory"
    },
    {
      "<C-v>",
      function()
        local oil = require("oil")
        oil.select({vertical = true })
      end,
      mode = "n",
      desc = "Open file in vertical split",
    },
    {
      "<C-\\>",
      function()
        local oil = require("oil")
        oil.select({vertical = true })
      end,
      mode = "n",
      desc = "Open file in vertical split",
    },
    {
      "<C-x>",
      function()
        local oil = require("oil")
        oil.select({horizontal = true })
      end,
      mode = "n",
      desc = "Open file in horizontal split",
    },
    {
      "<S-h>",
      function()
        local oil = require("oil.actions")
        oil.parent.callback()
      end,
      mode = "n",
      desc = "Move to parent directory",
    },
    {
      "<S-l>",
      function()
        local oil = require("oil")
        local entry = oil.get_cursor_entry()
        if entry == nil then
          return
        end

        if entry.type == "directory" then
          oil.select()
        end
      end,
      mode = "n",
      desc = "Open directory",
    },
    {
      "v",
      function()
        local oil = require("oil.actions")
        oil.preview.callback()
      end,
      mode = "n",
      desc = "Toggle preview window",
    },
    {
      "q",
      function()
        local oil = require("oil")
        local actions = require("oil.actions")
        oil.save(
          { confirm = true },
          function(err)
            if err == nil then
              actions.close.callback()
            elseif err == 'Canceled' then
              oil.discard_all_changes()
              actions.close.callback()
            else
              vim.notify("Unexpected error " .. err, vim.log.levels.ERROR)
            end
          end
        )
      end,
      mode = "n",
      desc = "Close explorer",
    },
    {
      "y",
      function()
        local oil = require("oil.actions")
        oil.yank_entry.callback()
      end,
      mode = "n",
      desc = "Copy filepath of current entry",
    },
    {
      "`",
      function()
        local oil = require("oil.actions")
        oil.cd.callback()
      end,
      mode = "n",
      desc = "cd to directory",
    },
    {
      "gx",
      function()
        local oil = require("oil.actions")
        oil.open_external.callback()
      end,
      mode = "n",
      desc = "cd to directory",
    },
  },
}

return M
