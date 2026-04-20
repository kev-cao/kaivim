local M = {}

M.obsidian = {
  bufkeys = {
    {
      "<localleader>o",
      "<cmd>Obsidian open<CR>",
      mode = "n",
      desc = "Open note in Obsidian",
    },
    {
      "<localleader>h",
      "<cmd>Obsidian toc<CR>",
      mode = "n",
      desc = "Show table of contents"
    },
    {
      "<localleader>t",
      "<cmd>Obsidian template<CR>",
      mode = "n",
      desc = "Insert a template into current note",
    },
    {
      "<localleader>l",
      "<cmd>Obsidian links<CR>",
      mode = "n",
      desc = "List links in current note",
    },
    {
      "<localleader>rr",
      function()
        vim.ui.input({ prompt = "New note name: " }, function(input)
          if input then
            vim.ui.input({ prompt = "Rename current note to '" .. input .. "'? (y/n): " }, function(confirm)
              if confirm == "y" or confirm == "Y" then
                vim.cmd("Obsidian rename " .. input)
              else
                vim.notify("Aborted note rename.", vim.log.levels.INFO)
              end
            end)
          end
        end)
      end,
      mode = "n",
      desc = "Rename current Obsidian note",
    },
    {
      "gr",
      "<cmd>Obsidian backlinks<CR>",
      mode = "n",
      desc = "Show backlinks to current note",
    },
  },
  keys = {
    {
      "<leader>of",
      "<cmd>Obsidian quick_switch<CR>",
      mode = "n",
      desc = "Search Obsidian notes",
    },
    {
      "<leader>or",
      "<cmd>Obsidian search<CR>",
      mode = "n",
      desc = "Search in Obsidian notes",
    },
  },
}
return M
