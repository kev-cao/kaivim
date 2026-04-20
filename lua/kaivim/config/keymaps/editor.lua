local func = require("kaivim.util.func")

local M = {}

M.marks = {
  keys = {
    {
      "<localleader>mm",
      function()
        vim.cmd("MarksListBuf")
        vim.cmd("lclose")
        vim.cmd("FzfLua loclist")
      end,
      mode = "n",
      desc = "List marks in buffer",
    },
    {
      "<leader>m<S-l>",
      function()
        vim.cmd("MarksListAll")
        vim.cmd("lclose")
        vim.cmd("FzfLua loclist")
      end,
      mode = "n",
      desc = "List all marks in open buffers",
    },
    {
      "<leader>m<C-l>",
      function()
        vim.cmd("MarksListGlobal")
        vim.cmd("lclose")
        vim.cmd("FzfLua loclist")
      end,
      mode = "n",
      desc = "List all global marks",
    },
    {
      "<leader>mp",
      "<Plug>(Marks-preview)",
      mode = "n",
      desc = "Preview specific mark",
    },
    {
      "<leader>m,",
      "<Plug>(Marks-setnext)",
      mode = "n",
      desc = "Set next alphabetical (lowercase) mark",
    },
    {
      "<leader>m;",
      "<Plug>(Marks-toggle)",
      mode = "n",
      desc = "Toggle next available mark on current line",
    },
    {
      "<leader>md",
      "<Plug>(Marks-delete)",
      mode = "n",
      desc = "Delete specific mark",
    },
    {
      "<leader>m<S-d>",
      "<Plug>(Marks-deleteline)",
      mode = "n",
      desc = "Delete all marks under cursor",
    },
    {
      "<localleader>m<S-d>",
      "<Plug>(Marks-deletebuf)",
      mode = "n",
      desc = "Delete marks in buffer",
    },
    {
      "<leader>mj",
      "<Plug>(Marks-next)",
      mode = "n",
      desc = "Next mark",
    },
    {
      "<leader>mk",
      "<Plug>(Marks-prev)",
      mode = "n",
      desc = "Previous mark",
    },
    {
      "<leader>mbL",
      function()
        vim.cmd("BookmarksListAll")
        vim.cmd("lclose")
        vim.cmd("FzfLua loclist")
      end,
      mode = "n",
      desc = "List all bookmarks",
    },
    {
      "<leader>mba",
      function()
        require("marks").annotate()
      end,
      mode = "n",
      desc = "Annotate bookmark under cursor",
    },
    {
      "<leader>mb<S-d>",
      "<Plug>(Marks-delete-bookmark)",
      mode = "n",
      desc = "Delete bookmark under cursor",
    },
    {
      "<leader>mb?",
      function()
        local opts = require("kaivim.config.opts").marks.opts
        local help_table = {}
        for i = 0, 9 do
          local group = opts["bookmark_" .. i]
          if group.virt_text == nil then
            goto continue
          end
          table.insert(help_table, "[" .. i .. "] " .. group.sign .. " : " .. group.virt_text)
          ::continue::
        end
        local max_text_length = 0
        for _, line in ipairs(help_table) do
          max_text_length = math.max(max_text_length, #line)
        end
        func.display_in_float(help_table, #help_table, math.min(max_text_length * 2, 80), {
          title = "Named Bookmark Groups (q to close)",
        })
      end,
      mode = "n",
      desc = "Show bookmark group info",
    },
  },
}
for i = 0, 9 do
  local opts = require("kaivim.config.opts").marks.opts
  local group = opts["bookmark_" .. i]
  local group_name = group.sign
  if group.virt_text ~= nil then
    group_name = group_name .. " : " .. group.virt_text
  end
  table.insert(M.marks.keys, {
    "<leader>mb" .. i,
    function()
      require("marks").bookmark_state:place_mark(i)
    end,
    mode = "n",
    desc = "Add to " .. group_name,
  })
  table.insert(M.marks.keys, {
    "<leader>mbl" .. i,
    function()
      vim.cmd("BookmarksList " .. i)
      vim.cmd("lclose")
      vim.cmd("FzfLua loclist")
    end,
    mode = "n",
    desc = group_name,
  })
  table.insert(M.marks.keys, {
    "<leader>mb<C-d>" .. i,
    function()
      require("marks").bookmark_state:delete_all(i)
    end,
    mode = "n",
    desc = group_name,
  })
  table.insert(M.marks.keys, {
    "<leader>m<S-j>" .. i,
    function()
      require("marks").bookmark_state:next(i)
    end,
    mode = "n",
    desc = group_name,
  })
  table.insert(M.marks.keys, {
    "<leader>m<S-k>" .. i,
    function()
      require("marks").bookmark_state:prev(i)
    end,
    mode = "n",
    desc = group_name,
  })
end

M.goto_preview = {
  keys = {
    {
      "gpd",
      function()
        require("goto-preview").goto_preview_definition({})
      end,
      mode = "n",
      desc = "Goto definition with preview",
    },
    {
      "gpt",
      function()
        require("goto-preview").goto_preview_type_definition({})
      end,
      mode = "n",
      desc = "Goto type definition with preview",
    },
    {
      "gpi",
      function()
        require("goto-preview").goto_preview_implementation({})
      end,
      mode = "n",
      desc = "Goto implementation with preview",
    },
    {
      "gpr",
      function()
        require("goto-preview").goto_preview_references()
      end,
      mode = "n",
      desc = "Goto references with preview",
    },
    {
      "gpq",
      function()
        require("goto-preview").close_all_win()
      end,
      mode = "n",
      desc = "Close all preview windows",
    },
  },
}

M.winshift = {
  keys = {
    {
      "<C-w>m",
      "<cmd>WinShift<CR>",
      mode = { "n", "t", "x" },
      desc = "Enter window move mode",
    }
  }
}

return M
