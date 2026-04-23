local keymaps = require("kaivim.util.keymaps")

--- @type PluginKeyMaps
local M = {}

M.fugitive = {
  keys = {
    {
      -- Visual mode selection marks are only set AFTER leaving visual mode.
      -- <Cmd> keeps you in the same mode, so we have to use : instead, which
      -- exits you from visual mode.
      "<localleader>gl",
      ":'<,'>GBrowse!<CR>",
      mode = "x",
      desc = "Copy GitHub URL for selection",
    },
    {
      "<leader>gm",
      keymaps.git.mergetool.open,
      mode = "n",
      desc = "Open git mergetool",
    },
  },
  bufkeys = {
    {
      "<localleader><S-w>",
      keymaps.git.mergetool.write,
      mode = "n",
      desc = "Write (stage) current file",
    },
    {
      "<localleader>j",
      "]c",
      mode = "n",
      desc = "Next hunk",
    },
    {
      "<localleader>k",
      "[c",
      mode = "n",
      desc = "Previous hunk",
    },
    {
      "<localleader><S-j>",
      keymaps.git.mergetool.next_file,
      mode = "n",
      desc = "Next conflicting file",
    },
    {
      "<localleader><S-k>",
      keymaps.git.mergetool.prev_file,
      mode = "n",
      desc = "Previous conflicting file",
    },
  },
  mainbufkeys = {
    {
      "<localleader>h",
      "<cmd>diffget //2<CR>",
      mode = "n",
      desc = "Get hunk from left",
    },
    {
      "<localleader>l",
      "<cmd>diffget //3<CR>",
      mode = "n",
      desc = "Get hunk from right",
    },
  },
}

M.gitsigns = {
  keys = {
    {
      "<leader>gs",
      "<cmd>Gitsigns toggle_signs<CR>",
      mode = "n",
      desc = "Toggle show Git signs",
    },
    {
      "<localleader>gd",
      "<cmd>Gitsigns toggle_word_diff<CR>",
      mode = "n",
      desc = "Toggle intra-line word-diff for this buffer",
    },
    {
      "<localleader>g<S-b>",
      "<cmd>Gitsigns blame<CR>",
      mode = "n",
      desc = "Show Git blame",
    },
    {
      "<localleader>gb",
      "<cmd>Gitsigns blame_line<CR>",
      mode = "n",
      desc = "Show Git blame for current line",
    },
  },
}

M.lazygit = {
  keys = {
    {
      "<leader>gg",
      "<cmd>LazyGit<CR>",
      mode = { "n", "t" },
      desc = "Open LazyGit",
    },
  },
}

M.octo = {
  keys = {
    {
      "<leader>gi",
      "<cmd>Octo issue list<CR>",
      mode = "n",
      desc = "List open issues",
    },
    {
      "<leader>gp",
      "<cmd>Octo pr list<CR>",
      mode = "n",
      desc = "List open PRs",
    },
    {
      "<leader>pw",
      "<cmd>Octo pr runs<CR>",
      mode = "n",
      desc = "List PR workflow runs",
      ft = "octo",
    },
  },
  bufgroups = {
    {
      "<localleader>i",
      group = "GitHub Issue",
      icon = { icon = "", color = "red" },
    },
    {
      "<localleader>p",
      group = "GitHub PR",
      icon = { icon = "", color = "orange" },
    },
    {
      "<localleader>c",
      group = "GitHub Comment",
      icon = { icon = "", color = "blue" },
    },
    {
      "<localleader>r",
      group = "GitHub Reaction",
      icon = { icon = "󰞅", color = "blue" },
    },
    {
      "<localleader>v",
      group = "GitHub Review",
      icon = { icon = "", color = "green" },
    },
    {
      "<localleader>f",
      group = "PR File Navigation",
      icon = { icon = "", color = "blue" },
    },
    {
      "<localleader>w",
      group = "PR Workflow",
      icon = { icon = "", color = "green" },
    },
    {
      "<localleader>l",
      group = "GitHub Label",
      icon = { icon = "󱍵", color = "green" },
    },
    {
      "<localleader>a",
      group = "GitHub Assign",
      icon = { icon = "", color = "blue" },
    },
  },
  -- Octo mode specific keymaps
  bufkeys = {
    runs = {
      expand_step = { lhs = "<CR>", desc = "expand workflow step" },
      open_in_browser = { lhs = "<localleader>wb", desc = "open workflow run in browser" },
      refresh = { lhs = "<C-r>", desc = "refresh workflow" },
      rerun = { lhs = "<localleader>wrr", desc = "rerun workflow" },
      rerun_failed = { lhs = "<localleader>wrf", desc = "rerun failed workflow" },
      cancel = { lhs = "<localleader>wx", desc = "cancel workflow" },
      copy_url = { lhs = "<localleader>wy", desc = "copy url to system clipboard" },
    },
    issue = {
      close_issue = { lhs = "<localleader>ic", desc = "close issue" },
      reopen_issue = { lhs = "<localleader>io", desc = "reopen issue" },
      list_issues = { lhs = "<localleader>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload issue" },
      open_in_browser = { lhs = "<localleader>ib", desc = "open issue in browser" },
      copy_url = { lhs = "<localleader>iy", desc = "copy url to clipboard" },
      add_assignee = { lhs = "<localleader>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<localleader>ad", desc = "remove assignee" },
      create_label = { lhs = "<localleader>lc", desc = "create label" },
      add_label = { lhs = "<localleader>la", desc = "add label" },
      remove_label = { lhs = "<localleader>ld", desc = "remove label" },
      add_comment = { lhs = "<localleader>ca", desc = "add comment" },
      delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
      next_comment = { lhs = "<localleader>cj", desc = "go to next comment" },
      prev_comment = { lhs = "<localleader>ck", desc = "go to previous comment" },
      react_hooray = { lhs = "<localleader>rp", desc = "add/remove 󱁖 reaction" },
      react_heart = { lhs = "<localleader>rh", desc = "add/remove  reaction" },
      react_eyes = { lhs = "<localleader>re", desc = "add/remove  reaction" },
      react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove  reaction" },
      react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove  reaction" },
      react_rocket = { lhs = "<localleader>rr", desc = "add/remove 󱓞 reaction" },
      react_laugh = { lhs = "<localleader>rl", desc = "add/remove  reaction" },
      react_confused = { lhs = "<localleader>rc", desc = "add/remove  reaction" },
    },
    pull_request = {
      checkout_pr = { lhs = "<localleader>pc", desc = "checkout PR" },
      merge_pr = { lhs = "<localleader>pm", desc = "merge commit PR" },
      squash_and_merge_pr = { lhs = "<localleader>psm", desc = "squash and merge PR" },
      rebase_and_merge_pr = { lhs = "<localleader>prm", desc = "rebase and merge PR" },
      list_commits = { lhs = "<localleader>pC", desc = "list PR commits" },
      list_changed_files = { lhs = "<localleader>pf", desc = "list PR changed files" },
      show_pr_diff = { lhs = "<localleader>pd", desc = "show PR diff" },
      add_reviewer = { lhs = "<localleader>ar", desc = "add reviewer" },
      remove_reviewer = { lhs = "<localleader>ard", desc = "remove reviewer request" },
      close_issue = { lhs = "<localleader>p<C-c>", desc = "close PR" },
      reopen_issue = { lhs = "<localleader>po", desc = "reopen PR" },
      reload = { lhs = "<C-r>", desc = "reload PR" },
      open_in_browser = { lhs = "<localleader>pb", desc = "open PR in browser" },
      copy_url = { lhs = "<localleader>py", desc = "copy url to clipboard" },
      goto_file = { lhs = "<localleader>fg", desc = "go to file" },
      add_assignee = { lhs = "<localleader>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<localleader>ad", desc = "remove assignee" },
      create_label = { lhs = "<localleader>lc", desc = "create label" },
      add_label = { lhs = "<localleader>la", desc = "add label" },
      remove_label = { lhs = "<localleader>ld", desc = "remove label" },
      add_comment = { lhs = "<localleader>ca", desc = "add comment" },
      delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
      next_comment = { lhs = "<localleader>cj", desc = "go to next comment" },
      prev_comment = { lhs = "<localleader>ck", desc = "go to previous comment" },
      react_hooray = { lhs = "<localleader>rp", desc = "add/remove 󱁖 reaction" },
      react_heart = { lhs = "<localleader>rh", desc = "add/remove  reaction" },
      react_eyes = { lhs = "<localleader>re", desc = "add/remove  reaction" },
      react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove  reaction" },
      react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove  reaction" },
      react_rocket = { lhs = "<localleader>rr", desc = "add/remove 󱓞 reaction" },
      react_laugh = { lhs = "<localleader>rl", desc = "add/remove  reaction" },
      react_confused = { lhs = "<localleader>rc", desc = "add/remove  reaction" },
      review_start = { lhs = "<localleader>vv", desc = "start a review for the current PR" },
      review_resume = { lhs = "<localleader>vr", desc = "resume a pending review for the current PR" },
      resolve_thread = { lhs = "<localleader>ptr", desc = "resolve PR thread" },
      unresolve_thread = { lhs = "<localleader>ptR", desc = "unresolve PR thread" },
    },
    review_thread = {
      add_comment = { lhs = "<localleader>ca", desc = "add comment" },
      add_suggestion = { lhs = "<localleader>cs", desc = "add suggestion" },
      delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
      next_comment = { lhs = "<localleader>cj", desc = "go to next comment" },
      prev_comment = { lhs = "<localleader>ck", desc = "go to previous comment" },
      select_next_entry = { lhs = "<localleader>fj", desc = "move to next changed file" },
      select_prev_entry = { lhs = "<localleader>fk", desc = "move to previous changed file" },
      select_first_entry = { lhs = "<localleader>fK", desc = "move to first changed file" },
      select_last_entry = { lhs = "<localleader>fJ", desc = "move to last changed file" },
      close_review_tab = { lhs = "<localleader>vx", desc = "close review tab" },
      react_hooray = { lhs = "<localleader>rp", desc = "add/remove 󱁖 reaction" },
      react_heart = { lhs = "<localleader>rh", desc = "add/remove  reaction" },
      react_eyes = { lhs = "<localleader>re", desc = "add/remove  reaction" },
      react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove  reaction" },
      react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove  reaction" },
      react_rocket = { lhs = "<localleader>rr", desc = "add/remove 󱓞 reaction" },
      react_laugh = { lhs = "<localleader>rl", desc = "add/remove  reaction" },
      react_confused = { lhs = "<localleader>rc", desc = "add/remove  reaction" },
      resolve_thread = { lhs = "<localleader>ptr", desc = "resolve PR thread" },
      unresolve_thread = { lhs = "<localleader>ptR", desc = "unresolve PR thread" },
    },
    submit_win = {
      approve_review = { lhs = "<localleader>vsa", desc = "approve review", mode = { "n", "i" } },
      comment_review = { lhs = "<localleader>vsm", desc = "comment review", mode = { "n", "i" } },
      request_changes = { lhs = "<localleader>vsc", desc = "request changes review", mode = { "n", "i" } },
      close_review_tab = { lhs = "<localleader>vx", desc = "close review tab", mode = { "n", "i" } },
    },
    review_diff = {
      submit_review = { lhs = "<localleader>vs", desc = "submit review" },
      discard_review = { lhs = "<localleader>vd", desc = "discard review" },
      add_review_comment = { lhs = "<localleader>ca", desc = "add a new review comment", mode = { "n", "x" } },
      add_review_suggestion = {
        lhs = "<localleader>cs",
        desc = "add a new review suggestion",
        mode = { "n", "x" },
      },
      focus_files = { lhs = "<localleader>fn", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<localleader>fb", desc = "hide/show changed files panel" },
      next_thread = { lhs = "<localleader>vtj", desc = "move to next thread" },
      prev_thread = { lhs = "<localleader>vtk", desc = "move to previous thread" },
      select_next_entry = { lhs = "<localleader>fj", desc = "move to next changed file" },
      select_prev_entry = { lhs = "<localleader>fk", desc = "move to previous changed file" },
      select_first_entry = { lhs = "<localleader>fK", desc = "move to first changed file" },
      select_last_entry = { lhs = "<localleader>fJ", desc = "move to last changed file" },
      close_review_tab = { lhs = "<localleader>vx", desc = "close review tab" },
      toggle_viewed = { lhs = "<localleader>v<space>", desc = "toggle viewer viewed state" },
      goto_file = { lhs = "<localleader>fg", desc = "go to file" },
    },
    file_panel = {
      submit_review = { lhs = "<localleader>vs", desc = "submit review" },
      discard_review = { lhs = "<localleader>vd", desc = "discard review" },
      next_entry = { lhs = "<localleader>fj", desc = "move to next changed file" },
      prev_entry = { lhs = "<localleader>fk", desc = "move to previous changed file" },
      select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
      refresh_files = { lhs = "<C-r>", desc = "refresh changed files panel" },
      focus_files = { lhs = "<localleader>fn", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<localleader>fb", desc = "hide/show changed files panel" },
      select_first_entry = { lhs = "<localleader>fK", desc = "move to first changed file" },
      select_last_entry = { lhs = "<localleader>fJ", desc = "move to last changed file" },
      close_review_tab = { lhs = "<localleader>vx", desc = "close review tab" },
      toggle_viewed = { lhs = "<localleader>v<space>", desc = "toggle viewer viewed state" },
    },
  },
}

return M
