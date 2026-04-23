--- @module 'plugins.notes'
--- Note-taking plugin configuration

return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    keys = function()
      local keymaps = require("kaivim.config.keymaps")
      return keymaps.obsidian.keys
    end,
    event = function()
      local vault = vim.fn.expand("~/Documents/obsidian")
      return {
        "BufReadPre " .. vault .. "/*.md",
        "BufReadPre " .. vault .. "/**/*.md",
        "BufNewFile " .. vault .. "/*.md",
        "BufNewFile " .. vault .. "/**/*.md",
      }
    end,
    opts = function()
      local vault = vim.fn.expand("~/Documents/obsidian")
      local function note_id()
        return string.format("id-%08x", os.time())
      end
      return {
        legacy_commands = false,
        workspaces = {
          { name = "obsidian", path = vault },
        },
        picker = {
          name = "fzf-lua",
          note_mappings = { new = "<C-n>", insert_link = "<C-l>" },
        },
        attachments = { folder = "attachments" },
        note_id_func = nil,
        frontmatter = {
          enabled = function(path) return not string.match(path, "%.claude/") end,
          func = function(note)
            local out = {
              uid = note_id(),
              aliases = note.aliases,
              categories = {},
            }
            if note.tags ~= nil then out.tags = note.tags end
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
              for k, v in pairs(note.metadata) do
                if k ~= "uid" or (v ~= nil and v ~= "" and v ~= vim.NIL) then
                  out[k] = v
                end
              end
            end
            return out
          end,
        },
        templates = {
          folder = "nvim-templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
          substitutions = {
            id = function() return note_id() end,
            today_week = function() return os.date("%Y-W%V") end,
            week_start_date = function()
              local current_time = os.time()
              local day_of_week_iso = tonumber(os.date("%u", current_time))
              local days_to_subtract = day_of_week_iso - 1
              local seconds_in_day = 60 * 60 * 24
              local first_day_time = current_time - (days_to_subtract * seconds_in_day)
              return os.date("%B %-e, %Y", first_day_time)
            end,
          },
        },
        completion = { min_chars = 0 },
      }
    end,
  },
  {
    "kev-cao/kai-obsidian.nvim",
    dependencies = {
      "obsidian-nvim/obsidian.nvim",
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
    },
    event = "VeryLazy",
    opts = {},
  },
}
